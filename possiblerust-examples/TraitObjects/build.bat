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

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:

set _CRATE_NAME=main

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

set _PELOOK_CMD=pelook.exe
goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd
set _RESET=[0m
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m

@rem normal foreground colors
set _NORMAL_FG_BLACK=[30m
set _NORMAL_FG_RED=[31m
set _NORMAL_FG_GREEN=[32m
set _NORMAL_FG_YELLOW=[33m
set _NORMAL_FG_BLUE=[34m
set _NORMAL_FG_MAGENTA=[35m
set _NORMAL_FG_CYAN=[36m
set _NORMAL_FG_WHITE=[37m

@rem normal background colors
set _NORMAL_BG_BLACK=[40m
set _NORMAL_BG_RED=[41m
set _NORMAL_BG_GREEN=[42m
set _NORMAL_BG_YELLOW=[43m
set _NORMAL_BG_BLUE=[44m
set _NORMAL_BG_MAGENTA=[45m
set _NORMAL_BG_CYAN=[46m
set _NORMAL_BG_WHITE=[47m

@rem strong foreground colors
set _STRONG_FG_BLACK=[90m
set _STRONG_FG_RED=[91m
set _STRONG_FG_GREEN=[92m
set _STRONG_FG_YELLOW=[93m
set _STRONG_FG_BLUE=[94m
set _STRONG_FG_MAGENTA=[95m
set _STRONG_FG_CYAN=[96m
set _STRONG_FG_WHITE=[97m

@rem strong background colors
set _STRONG_BG_BLACK=[100m
set _STRONG_BG_RED=[101m
set _STRONG_BG_GREEN=[102m
set _STRONG_BG_YELLOW=[103m
set _STRONG_BG_BLUE=[104m
goto :eof

@rem input parameter: %*
@rem output parameter(s): _CLEAN, _COMPILE, _RUN, _DEBUG, _TEST, _VERBOSE
:args
set _CLEAN=0
set _COMPILE=0
set _DOC=0
set _DUMP=0
set _EDITION=2018
set _HELP=0
set _RUN=0
set _TARGET=msvc
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
    ) else if "%__ARG%"=="-target:cl" ( set _TARGET=msvc
    ) else if "%__ARG%"=="-target:gcc" ( set _TARGET=gnu
    ) else if "%__ARG%"=="-target:gnu" ( set _TARGET=gnu
    ) else if "%__ARG%"=="-target:msvc" ( set _TARGET=msvc
    ) else if "%__ARG%"=="-timer" ( set _TIMER=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option %__ARG% 1>&2
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
        echo %_ERROR_LABEL% Unknown subcommand %__ARG% 1>&2
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

@rem General format: <arch>-<vendor>-<sys>-<abi> where
@rem arch   = x86_64, i686, arm, mips, etc.
@rem vendor = unknown, pc, etc.
@rem sys    = none, linux, windows, etc.
@rem abi    = gnu, android, elf, msvc, etc.
@rem Command: rustc --print target-list | findstr windows
set __TARGET_ARCH=x86_64
set __TARGET_VENDOR=pc
set __TARGET_SYS=windows
set _TARGET_TRIPLE=%__TARGET_ARCH%-%__TARGET_VENDOR%-%__TARGET_SYS%-%_TARGET%

if %_TARGET%==gnu if not defined MSYS_HOME (
    echo %_ERROR_LABEL% MSYS installation not found 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _EDITION=%_EDITION% _TARGET=%_TARGET% _TIMER=%_TIMER% _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _CLEAN=%_CLEAN% _COMPILE=%_COMPILE% _DOC=%_DOC% _DUMP=%_DUMP% _RUN=%_RUN% _TEST=%_TEST% 1>&2
    echo %_DEBUG_LABEL% Variables  : CARGO_HOME="%CARGO_HOME%" MSYS_HOME="%MSYS_HOME%" 1>&2
)
if %_TIMER%==1 for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set _TIMER_START=%%i
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%%_UNDERSCORE%
    set __BEG_O=%_STRONG_FG_GREEN%
    set __BEG_N=%_NORMAL_FG_YELLOW%
    set __END=%_RESET%
) else (
    set __BEG_P=
    set __BEG_O=
    set __BEG_N=
    set __END=
)
echo Usage: %__BEG_O%%_BASENAME% { ^<option^> ^| ^<subcommand^> }%__END%
echo.
echo   %__BEG_P%Options:%__END%
echo     %__BEG_O%-debug%__END%                show commands executed by this script
echo     %__BEG_O%-edition:^<2015^|2018^>%__END%  set Rust edition 
echo     %__BEG_O%-target:^<gcc^|msvc^>%__END%    set plaform target ^(default: %__BEG_O%msvc%__END%/%__BEG_O%cl%__END%^)
echo     %__BEG_O%-timer%__END%                display total elapsed time
echo     %__BEG_O%-verbose%__END%              display progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%clean%__END%                 delete generated files
echo     %__BEG_O%compile%__END%               generate executable
echo     %__BEG_O%doc%__END%                   generate HTML documentation
echo     %__BEG_O%dump%__END%                  dump PE/COFF infos for generated executable
echo     %__BEG_O%help%__END%                  display this help message
echo     %__BEG_O%run%__END%                   run generated executable
echo     %__BEG_O%test%__END%                  test generated executable
goto :eof

:clean
call :rmdir "%_TARGET_DIR%"
if exist "%_ROOT_DIR%\Cargo.lock" del "%_ROOT_DIR%\Cargo.lock" 1>NUL
goto :eof

@rem input parameter: %1=directory path
:rmdir
set "__DIR=%~1"
if not exist "!__DIR!\" goto :eof
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% rmdir /s /q "!__DIR!" 1>&2
) else if %_VERBOSE%==1 ( echo Delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
)
rmdir /s /q "!__DIR!"
if not %ERRORLEVEL%==0 (
    set _EXITCODE=1
    goto :eof
)
goto :eof

:compile
if not exist "%_TARGET_DIR%" mkdir "%_TARGET_DIR%"

call :action_required "%_TARGET_DIR%\%_CRATE_NAME%.exe" "%_SOURCE_DIR%\*.rs"
if %_ACTION_REQUIRED%==0 goto :eof

set __SOURCE_FILES=
set __N=0
for %%f in (%_SOURCE_DIR%\*.rs) do (
    set __SOURCE_FILES=!__SOURCE_FILES! "%%f"
    set /a __N+=1
)
if %__N%==0 (
    echo %_WARNING_LABEL% No Rust source file found 1>&2
    goto :eof
) else if %__N%==1 ( set __N_FILES=%__N% Rust source file
) else ( set __N_FILES=%__N% Rust source files
)
set __PATH=%PATH%
@rem We add gcc.exe to PATH if _TARGET=gnu
if %_TARGET%==gnu set "PATH=%PATH%;%MSYS_HOME%\mingw64\bin"

@rem Lint levels: -A (allow), -W (warning), -D (deny), -F (forbid)
@rem See https://doc.rust-lang.org/rustc/lints/levels.html
set _RUST_LINT_OPTS=

@rem should work (https://github.com/rust-lang/rust/issues/63576)
@rem set "__OPTS_FILE=%_TARGET_DIR%\rustc_opts.txt"
@rem echo %_RUSTC_OPTS% > "%__OPTS_FILE%"
set __RUST_CRATE_OPTS=--crate-name "%_CRATE_NAME%" --crate-type bin
set __RUSTC_OPTS=%_RUST_LINT_OPTS% %__RUST_CRATE_OPTS% --edition %_EDITION% --out-dir "%_TARGET_DIR%" --target "%_TARGET_TRIPLE%"
if %_DEBUG%==1 set __RUSTC_OPTS=-g %__RUSTC_OPTS%

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_RUSTC_CMD%" %__RUSTC_OPTS% %__SOURCE_FILES% 1>&2
) else if %_VERBOSE%==1 ( echo Compile %__N_FILES% to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_RUSTC_CMD%" %__RUSTC_OPTS% %__SOURCE_FILES%
if not %ERRORLEVEL%==0 (
    if %_TARGET%==gnu set "PATH=%__PATH%"
    echo %_ERROR_LABEL% Failed to compile %__N_FILES% to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_TARGET%==gnu set "PATH=%__PATH%"
goto :eof

@rem Generated index page is %_TARGET_DOCS_DIR%\%_CRATE_NAME%\index.html
:doc
if not exist "%_TARGET_DOCS_DIR%" mkdir "%_TARGET_DOCS_DIR%"

set __SOURCE_FILES=
set __N=0
for %%f in (%_SOURCE_DIR%\*.rs) do (
    set __SOURCE_FILES=!__SOURCE_FILES! "%%f"
    set /a __N+=1
)
set __RUST_CRATE_OPTS=--crate-name "%_CRATE_NAME%" --crate-type bin
set __RUSTDOC_OPTS=%__RUST_CRATE_OPTS% --edition %_EDITION% --output "%_TARGET_DOCS_DIR%" --document-private-items

if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_RUSTDOC_CMD%" %__RUSTDOC_OPTS% %__SOURCE_FILES% 1>&2
) else if %_VERBOSE%==1 ( echo Generate HTML documentation into directory "!_TARGET_DOCS_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_RUSTDOC_CMD%" %__RUSTDOC_OPTS% %__SOURCE_FILES%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to generate HTML documentation 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:dump
set "__EXE_FILE=%_TARGET_DIR%\%_CRATE_NAME%.exe"
if not exist "%__EXE_FILE%" (
    echo %_ERROR_LABEL% Executable %_CRATE_NAME%.exe not found 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% "%_PELOOK_CMD%" %_PELOOK_OPTS% "!__EXE_FILE:%_ROOT_DIR%=!" 1>&2
    call "%_PELOOK_CMD%" %_PELOOK_OPTS% "%__EXE_FILE%"
) else (
    if %_VERBOSE%==1 echo Dump PE/COFF infos for executable !__EXE_FILE:%_ROOT_DIR%=! 1>&2
    echo executable:           !__EXE_FILE:%_ROOT_DIR%=!
    call "%_PELOOK_CMD%" %_PELOOK_OPTS% "%__EXE_FILE%" | findstr "signature machine linkver modules"
)
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Dump of executable %_CRATE_NAME%.exe failed 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:run
set "__EXE_FILE=%_TARGET_DIR%\%_CRATE_NAME%.exe"
if not exist "%__EXE_FILE%" (
    echo %_ERROR_LABEL% Executable %_CRATE_NAME%.exe not found 1>&2
    set _EXITCODE=1
    goto :eof
)
call "%__EXE_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Execution status is %ERRORLEVEL% 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:test
goto :eof

@rem input parameter: 1=target file 2,3,..=path (wildcards accepted)
@rem output parameter: _ACTION_REQUIRED
:action_required
set "__TARGET_FILE=%~1"

set __PATH_ARRAY=
set __PATH_ARRAY1=
:action_path
shift
set "__PATH=%~1"
if not defined __PATH goto action_next
if defined __PATH_ARRAY set "__PATH_ARRAY=%__PATH_ARRAY%,"
set __PATH_ARRAY=%__PATH_ARRAY%'%__PATH%'
if defined __PATH_ARRAY1 set "__PATH_ARRAY1=%__PATH_ARRAY1%,"
set __PATH_ARRAY1=%__PATH_ARRAY1%'!__PATH:%_ROOT_DIR%=!'
goto action_path

:action_next
set __TARGET_TIMESTAMP=00000000000000
for /f "usebackq" %%i in (`powershell -c "gci -path '%__TARGET_FILE%' -ea Stop | select -last 1 -expandProperty LastWriteTime | Get-Date -uformat %%Y%%m%%d%%H%%M%%S" 2^>NUL`) do (
     set __TARGET_TIMESTAMP=%%i
)
set __SOURCE_TIMESTAMP=00000000000000
for /f "usebackq" %%i in (`powershell -c "gci -recurse -path %__PATH_ARRAY% -ea Stop | sort LastWriteTime | select -last 1 -expandProperty LastWriteTime | Get-Date -uformat %%Y%%m%%d%%H%%M%%S" 2^>NUL`) do (
    set __SOURCE_TIMESTAMP=%%i
)
call :newer %__SOURCE_TIMESTAMP% %__TARGET_TIMESTAMP%
set _ACTION_REQUIRED=%_NEWER%
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% %__TARGET_TIMESTAMP% Target : '%__TARGET_FILE%' 1>&2
    echo %_DEBUG_LABEL% %__SOURCE_TIMESTAMP% Sources: %__PATH_ARRAY% 1>&2
    echo %_DEBUG_LABEL% _ACTION_REQUIRED=%_ACTION_REQUIRED% 1>&2
) else if %_VERBOSE%==1 if %_ACTION_REQUIRED%==0 if %__SOURCE_TIMESTAMP% gtr 0 (
    echo No action required ^(%__PATH_ARRAY1%^) 1>&2
)
goto :eof

@rem output parameter: _NEWER
:newer
set __TIMESTAMP1=%~1
set __TIMESTAMP2=%~2

set __DATE1=%__TIMESTAMP1:~0,8%
set __TIME1=%__TIMESTAMP1:~-6%

set __DATE2=%__TIMESTAMP2:~0,8%
set __TIME2=%__TIMESTAMP2:~-6%

if %__DATE1% gtr %__DATE2% ( set _NEWER=1
) else if %__DATE1% lss %__DATE2% ( set _NEWER=0
) else if %__TIME1% gtr %__TIME2% ( set _NEWER=1
) else ( set _NEWER=0
)
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
