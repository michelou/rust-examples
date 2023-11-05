@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging !
set _DEBUG=0

@rem #########################################################################
@rem ## Environment setup

set _EXITCODE=0

call :env
if not %_EXITCODE%==0 goto end

call :args %*
if not %_EXITCODE%==0 goto end

@rem #########################################################################
@rem ## Main

if %_HELP%==1 (
    call :help
    exit /b !_EXITCODE!
)
if %_CLEAN%==1 (
    call :clean
    if not !_EXITCODE!==0 goto end
)
if %_COMPILE%==1 (
    call :compile
    if not !_EXITCODE!==0 goto end
)
if %_DOC%==1 (
    call :doc
    if not !_EXITCODE!==0 goto end
)
if %_DUMP%==1 (
    call :dump
    if not !_EXITCODE!==0 goto end
)
if %_RUN%==1 (
    call :run
    if not !_EXITCODE!==0 goto end
)
if %_TEST%==1 (
    call :test
    if not !_EXITCODE!==0 goto end
)
goto end

@rem #########################################################################
@rem ## Subroutines

@rem output parameters: _DEBUG_LABEL, _ERROR_LABEL, _WARNING_LABEL
@rem                    _CRATE_NAME, _SOURCE_DIR, _TARGET_DIR
:env
set _BASENAME=%~n0
set "_ROOT_DIR=%~dp0"

@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd
set _DEBUG_LABEL=[46m[%_BASENAME%][0m
set _ERROR_LABEL=[91mError[0m:
set _WARNING_LABEL=[93mWarning[0m:

set _CRATE_NAME=hello

set "_SOURCE_DIR=%_ROOT_DIR%src"
set "_TARGET_DIR=%_ROOT_DIR%target"
set "_TARGET_DOCS_DIR=%_TARGET_DIR%\docs"

if not exist "%CARGO_HOME%\bin\rustc.exe" (
    echo %_ERROR_LABEL% Rust installation not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_RUSTC_CMD=%CARGO_HOME%\bin\rustc.exe"
set "_RUSTDOC_CMD=%CARGO_HOME%\bin\rustdoc.exe"
goto :eof

@rem input parameter: %*
@rem output parameters: _CLEAN, _COMPILE, _RUN, _DEBUG, _TEST, _VERBOSE
:args
set _CLEAN=0
set _COMPILE=0
set _DOC=0
set _DUMP=0
set _EDITION=2018
set _HELP=0
set _RUN=0
set _TEST=0
set _TIMER=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG (
    if !__N!==0 set _HELP=1
    goto args_done
)
if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-edition:2015" ( set _EDITION=2015
    ) else if "%__ARG%"=="-edition:2018" ( set _EDITION=2018
    ) else if "%__ARG%"=="-help" ( set _HELP=1
    ) else if "%__ARG%"=="-timer" ( set _TIMER=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="clean" ( set _CLEAN=1
    ) else if "%__ARG%"=="compile" ( set _COMPILE=1
    ) else if "%__ARG%"=="doc" ( set _DOC=1
    ) else if "%__ARG%"=="dump" ( set _COMPILE=1& set _DUMP=1
    ) else if "%__ARG%"=="help" ( set _HELP=1
    ) else if "%__ARG%"=="run" ( set _COMPILE=1& set _RUN=1
    ) else if "%__ARG%"=="test" ( set _COMPILE=1& set _RUN=1& set _TEST=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto :args_loop
:args_done
set _STDOUT_REDIRECT=1^>NUL
if %_DEBUG%==1 set _STDOUT_REDIRECT=1^>^&2

if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _EDITION=%_EDITION% _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _CLEAN=%_CLEAN% _COMPILE=%_COMPILE% _DOC=%_DOC% _DUMP=%_DUMP% _RUN=%_RUN% _TEST=%_TEST% 1>&2
    echo %_DEBUG_LABEL% Variables  : "CARGO_HOME=%CARGO_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "MSYS_HOME=%MSYS_HOME%" 1>&2
)
if %_TIMER%==1 for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set _TIMER_START=%%i
goto :eof

:help
echo Usage: %_BASENAME% { ^<option^> ^| ^<subcommand^> }
echo.
echo   Options:
echo     -debug      print commands executed by this script
echo     -timer      print total execution time
echo     -verbose    print progress messages
echo.
echo   Subcommands:
echo     clean       delete generated files
echo     compile     generate executable
echo     dump        dump PE/COFF infos for generated executable
echo     help        print this help message
echo     run         run generated executable
echo     test        test generated executable
goto :eof

:clean
call :rmdir "%_TARGET_DIR%"
if exist "%_ROOT_DIR%\Cargo.lock" del "%_ROOT_DIR%\Cargo.lock" 1>NUL
goto :eof

@rem input parameter: %1=directory path
:rmdir
set "__DIR=%~1"
if not exist "%__DIR%\" goto :eof
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% rmdir /s /q "%__DIR%" 1>&2
) else if %_VERBOSE%==1 ( echo Delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
)
rmdir /s /q "%__DIR%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:compile
setlocal
if not exist "%_TARGET_DIR%" mkdir "%_TARGET_DIR%"

set __SOURCE_FILES=
set __N=0
for /f "delims=" %%f in ('dir /b /s "%_SOURCE_DIR%\*.rs" 2^>NUL') do (
    set __SOURCE_FILES=!__SOURCE_FILES! "%%f"
    set /a __N+=1
)
if %__N%==0 (
    echo %_WARNING_LABEL% No Rust source file found 1>&2
    goto :eof
) else if %__N%==1 ( set __N_FILES=%__N% Rust source file
) else ( set __N_FILES=%__N% Rust source files
)
set __RUSTC_OPTS=--out-dir "%_TARGET_DIR%" --crate-name "%_CRATE_NAME%" --edition %_EDITION%

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_RUSTC_CMD%" %__RUSTC_OPTS% %__SOURCE_FILES% 1>&2
) else if %_VERBOSE%==1 ( echo Compile %__N_FILES% to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_RUSTC_CMD%" %__RUSTC_OPTS% %__SOURCE_FILES%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to compile %__N_FILES% to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

@rem Generated index page is %_TARGET_DOCS_DIR%\%_CRATE_NAME%\index.html
:doc
if not exist "%_TARGET_DOCS_DIR%" mkdir "%_TARGET_DOCS_DIR%"

set __SOURCE_FILES=
for /f "delims=" %%f in ('dir /b /s "%_SOURCE_DIR%\*.rs" 2^>NUL') do (
    set __SOURCE_FILES=!__SOURCE_FILES! "%%f"
)
set __RUSTDOC_OPTS=%_RUST_CRATE_OPTS% --output "%_TARGET_DOCS_DIR%" --document-private-items

if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_RUSTDOC_CMD%" %__RUSTDOC_OPTS% %__SOURCE_FILES% 1>&2
) else if %_VERBOSE%==1 ( echo Generate HTML documentation into directory !_TARGET_DOCS_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_RUSTDOC_CMD%" %__RUSTDOC_OPTS% %__SOURCE_FILES%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to generate documentation into directory !_TARGET_DOCS_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:dump
set "__EXE_FILE=%_TARGET_DIR%\%_CRATE_NAME%.exe"
if not exist "%__EXE_FILE%" (
    echo %_ERROR_LABEL% Rust program "%_CRATE_NAME%.exe" not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set __PELOOK_OPTS=

if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% %_PELOOK_CMD% %__PELOOK_OPTS% !__EXE_FILE:%_ROOT_DIR%=! 1>&2
    call "%_PELOOK_CMD%" %__PELOOK_OPTS% "%__EXE_FILE%"
) else (
    if %_VERBOSE%==1 echo Dump PE/COFF infos for executable "!__EXE_FILE:%_ROOT_DIR%=!" 1>&2
    echo executable:           !__EXE_FILE:%_ROOT_DIR%=!
    call "%_PELOOK_CMD%" %__PELOOK_OPTS% "%__EXE_FILE%" | findstr "signature machine linkver modules"
)
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to dump Rust program "%_CRATE_NAME%.exe" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:run
set "__EXE_FILE=%_TARGET_DIR%\%_CRATE_NAME%.exe"
if not exist "%__EXE_FILE%" (
    echo %_ERROR_LABEL% Rust program "%_CRATE_NAME%.exe" not found 1>&2
    set _EXITCODE=1
    goto :eof
)
call "%__EXE_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to execute Rust program "%_CRATE_NAME%.exe" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:test
echo %_WARNING_LABEL% Subcommand "test" not yet implemented 1>&2
goto :eof

@rem output parameter: _DURATION
:duration
set __START=%~1
set __END=%~2

for /f "delims=" %%i in ('powershell -c "$interval = New-TimeSpan -Start '%__START%' -End '%__END%'; Write-Host $interval"') do set _DURATION=%%i
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
if %_TIMER%==1 (
    for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set __TIMER_END=%%i
    call :duration "%_TIMER_START%" "!__TIMER_END!"
    echo Total execution time: !_DURATION! 1>&2
)
if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
exit /b %_EXITCODE%
endlocal
