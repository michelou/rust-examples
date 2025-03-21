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

for %%i in (%_COMMANDS%) do (
    call :%%i
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

set "_SOURCE_DIR=%_ROOT_DIR%src"
set "_TARGET_DIR=%_ROOT_DIR%target"
set "_TARGET_DEPS_DIR=%_TARGET_DIR%\deps"
set "_TARGET_DOCS_DIR=%_TARGET_DIR%\docs"

if not exist "%CARGO_HOME%\bin\rustc.exe" (
    echo %_ERROR_LABEL% Rust installation not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_RUSTC_CMD=%CARGO_HOME%\bin\rustc.exe"
set "_RUSTDOC_CMD=%CARGO_HOME%\bin\rustdoc.exe"
set "_CARGO_CMD=%CARGO_HOME%\bin\cargo.exe"

set _EDITION_DEFAULT=2021

if not exist "%GIT_HOME%\usr\bin\unzip.exe" (
    echo %_ERROR_LABEL% Unzip command not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_UNZIP_CMD=%GIT_HOME%\usr\bin\unzip.exe"

@rem use newer PowerShell version if available
where /q pwsh.exe
if %ERRORLEVEL%==0 ( set _PWSH_CMD=pwsh.exe
) else ( set _PWSH_CMD=powershell.exe
)
set _PELOOK_CMD=pelook.exe
goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd

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

@rem we define _RESET in last position to avoid crazy console output from type command
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m
set _RESET=[0m
goto :eof

@rem input parameter: %*
@rem output parameters: _COMMANDS, _DEBUG, _TARGET, _VERBOSE
:args
set _COMMANDS=
set _EDITION=%_EDITION_DEFAULT%
set _TARGET=msvc
set _TIMER=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG (
    if !__N!==0 set _COMMANDS=help
    goto args_done
)
if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-edition:2015" ( set _EDITION=2015
    ) else if "%__ARG%"=="-edition:2018" ( set _EDITION=2018
    ) else if "%__ARG%"=="-edition:2021" ( set _EDITION=2021
    ) else if "%__ARG%"=="-help" ( set _COMMANDS=help
    ) else if "%__ARG%"=="-target:cl" ( set _TARGET=msvc
    ) else if "%__ARG%"=="-target:gcc" ( set _TARGET=gnu
    ) else if "%__ARG%"=="-target:gnu" ( set _TARGET=gnu
    ) else if "%__ARG%"=="-target:msvc" ( set _TARGET=msvc
    ) else if "%__ARG%"=="-timer" ( set _TIMER=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="clean" ( set _COMMANDS=!_COMMANDS! clean
    ) else if "%__ARG%"=="compile" ( set _COMMANDS=!_COMMANDS! compile
    ) else if "%__ARG%"=="doc" ( set _COMMANDS=!_COMMANDS! doc
    ) else if "%__ARG%"=="dump" ( set _COMMANDS=!_COMMANDS! compile dump
    ) else if "%__ARG%"=="help" ( set _COMMANDS=help
    ) else if "%__ARG%"=="run" ( set _COMMANDS=!_COMMANDS! compile run
    ) else if "%__ARG%"=="test" ( set _COMMANDS=!_COMMANDS! compile run test
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto args_loop
:args_done
set _STDOUT_REDIRECT=1^>NUL
if %_DEBUG%==1 set _STDOUT_REDIRECT=1^>^&2

set _CRATE_NAME=main

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
    echo %_DEBUG_LABEL% Subcommands: %_COMMANDS% 1>&2
    echo %_DEBUG_LABEL% Variables  : "CARGO_HOME=%CARGO_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "GIT_HOME=%GIT_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "MSYS_HOME=%MSYS_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "RUSTUP_HOME=%RUSTUP_HOME%" 1>&2
)
if %_TIMER%==1 for /f "delims=" %%i in ('call "%_PWSH_CMD%" -c "(Get-Date)"') do set _TIMER_START=%%i
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%
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
echo     %__BEG_O%-debug%__END%                print commands executed by this script
echo     %__BEG_O%-edition:^<edition^>%__END%  set Rust edition ^(default: %_BEG_O%%_EDITION_DEFAULT%%__END%^)
echo     %__BEG_O%-target:^<gcc^|msvc^>%__END%    set plaform target ^(default: %__BEG_O%msvc%__END%/%__BEG_O%cl%__END%^)
echo     %__BEG_O%-timer%__END%                print total execution time
echo     %__BEG_O%-verbose%__END%              print progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%clean%__END%                 delete generated files
echo     %__BEG_O%compile%__END%               generate executable
echo     %__BEG_O%doc%__END%                   generate HTML documentation
echo     %__BEG_O%dump%__END%                  dump PE/COFF infos for generated executable
echo     %__BEG_O%help%__END%                  print this help message
echo     %__BEG_O%run%__END%                   run generated executable
echo     %__BEG_O%test%__END%                  test generated executable
echo.
echo   %__BEG_P%Values:%__END%
echo     %__BEG_O%^<edition^>%__END% : 2015, 2018, 2021
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

call :compile_deps
if not %_EXITCODE%==0 goto :eof

set __SOURCE_FILES=
set __N=0
for /f "delims=" %%f in ('dir /b /s "%_SOURCE_DIR%\main\rust\*.rs" 2^>NUL') do (
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
set __RUST_DEPS_OPTS=-L "dependency=%_TARGET_DEPS_DIR%"
set __RUST_DEPS_OPTS=%__RUST_DEPS_OPTS% --extern "rand=%_TARGET_DEPS_DIR%\librand.rlib"
set __RUST_DEPS_OPTS=%__RUST_DEPS_OPTS% --extern "rayon=%_TARGET_DEPS_DIR%\librayon.rlib"
set __RUSTC_OPTS=%_RUST_LINT_OPTS% %__RUST_CRATE_OPTS% --edition %_EDITION% --out-dir "%_TARGET_DIR%" --target "%_TARGET_TRIPLE%"
if %_DEBUG%==1 ( set __RUSTC_OPTS=-g %__RUSTC_OPTS%
) else ( set __RUSTC_OPTS=-Clink-arg=/DEBUG:NONE %__RUSTC_OPTS%
)

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_RUSTC_CMD%" %__RUSTC_OPTS% %__SOURCE_FILES% %__RUST_DEPS_OPTS% 1>&2
) else if %_VERBOSE%==1 ( echo Compile %__N_FILES% to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_RUSTC_CMD%" %__RUSTC_OPTS% %__SOURCE_FILES% %__RUST_DEPS_OPTS%
if not %ERRORLEVEL%==0 (
    if %_TARGET%==gnu set "PATH=%__PATH%"
    echo %_ERROR_LABEL% Failed to compile %__N_FILES% to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_TARGET%==gnu set "PATH=%__PATH%"
goto :eof

:compile_deps
if not exist "%_TARGET_DEPS_DIR%" mkdir "%_TARGET_DEPS_DIR%"

set __URL_RAND_ZIP=https://github.com/rust-random/rand/archive/refs/tags/0.9.0-beta.3.zip
set __URL_RAYON_ZIP=https://github.com/rayon-rs/rayon/archive/refs/tags/v1.10.0.zip

call :download_dep "%__URL_RAND_ZIP%" "%_TARGET_DIR%\rand-0.9.0-beta.3.zip"
if not %_EXITCODE%==0 goto :eof

call :download_dep "%__URL_RAYON_ZIP%" "%_TARGET_DIR%\rayon-1.10.0.zip"
if not %_EXITCODE%==0 goto :eof

call :action_required "%_TARGET_DEPS_DIR%\librand.rlib" "%_TARGET_DIR%\rand-0.9.0-beta.3.zip"
if %_ACTION_REQUIRED%==1 goto :compile_deps_next

call :action_required "%_TARGET_DEPS_DIR%\librayon.rlib" "%_TARGET_DIR%\rayon-1.10.0.zip"
if %_ACTION_REQUIRED%==0 goto :eof

:compile_deps_next
set __UNZIP_OPTS=-o -q

for /f "delims=" %%f in ('dir /s /b "%_TARGET_DIR%\*.zip"') do (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_UNZIP_CMD%" %__UNZIP_OPTS% "%%f" -d "%_TARGET_DIR%" 1>&2
    call "%_UNZIP_CMD%" %__UNZIP_OPTS% "%%f" -d "%_TARGET_DIR%"
    pushd "%_TARGET_DIR%\%%~nf"
    if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "!_CARGO_CMD:%USERPROFILE%=%%USERPROFILE%%!" -q build ^("!_TARGET_DIR:%_ROOT_DIR%=!\%%~nf"^) 1>&2
    ) else if %_VERBOSE%==1 ( echo Build library dependency in directory "!_TARGET_DIR:%_ROOT_DIR%=!\%%~nf" 1>&2
    )
    call "%_CARGO_CMD%" -q build 2>NUL
    popd
    for /f "delims=" %%g in ('dir /s /b "%_TARGET_DIR%\%%~nf\*.rlib" "%_TARGET_DIR%\%%~nf\*.dll"') do (
        for /f "tokens=1,* delims=-" %%m in ("%%~ng") do set "__FILE_NAME=%%m%%~xg"
        @rem if %_DEBUG%==1 echo %_DEBUG_LABEL% copy "%%g" "%_TARGET_DEPS_DIR%\!__FILE_NAME!" 1>&2
        copy "%%g" "%_TARGET_DEPS_DIR%\!__FILE_NAME!" 1>NUL
    )
)
goto :eof

@rem input parameters: %1=Zip URL, %2=Zip output path
:download_dep
set "__ZIP_URL=%~1"
set "__ZIP_FILE=%~2"

if exist "%__ZIP_FILE%" goto :eof

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_PWSH_CMD%" -C "Invoke-WebRequest -Uri '%__ZIP_URL%' -OutFile '%__ZIP_FILE%'" 1>&2
) else if %_VERBOSE%==1 ( echo Download library "!__ZIP_FILE:%_TARGET_DIR%\=!" to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_PWSH_CMD%" -C "$progressPreference='silentlyContinue';Invoke-WebRequest -Uri '%__ZIP_URL%' -OutFile '%__ZIP_FILE%'"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to download library "!__ZIP_FILE:%_TARGET_DIR%\=!" to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

@rem input parameter: 1=target file 2=path (wildcards accepted)
@rem output parameter: _ACTION_REQUIRED
:action_required
set __TARGET_FILE=%~1
set __PATH=%~2

set __TARGET_TIMESTAMP=00000000000000
for /f "usebackq" %%i in (`call "%_PWSH_CMD%" -c "gci -path '%__TARGET_FILE%' -ea Stop | select -last 1 -expandProperty LastWriteTime | Get-Date -uformat %%Y%%m%%d%%H%%M%%S" 2^>NUL`) do (
     set __TARGET_TIMESTAMP=%%i
)
set __SOURCE_TIMESTAMP=00000000000000
for /f "usebackq" %%i in (`call "%_PWSH_CMD%" -c "gci -recurse -path '%__PATH%' -ea Stop | sort LastWriteTime | select -last 1 -expandProperty LastWriteTime | Get-Date -uformat %%Y%%m%%d%%H%%M%%S" 2^>NUL`) do (
    set __SOURCE_TIMESTAMP=%%i
)
call :newer %__SOURCE_TIMESTAMP% %__TARGET_TIMESTAMP%
set _ACTION_REQUIRED=%_NEWER%
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% %__TARGET_TIMESTAMP% Target : "%__TARGET_FILE%" 1>&2
    echo %_DEBUG_LABEL% %__SOURCE_TIMESTAMP% Sources: "%__PATH%" 1>&2
    echo %_DEBUG_LABEL% _ACTION_REQUIRED=%_ACTION_REQUIRED% 1>&2
) else if %_VERBOSE%==1 if %_ACTION_REQUIRED%==0 if %__SOURCE_TIMESTAMP% gtr 0 (
    echo No action required ^("!__PATH:%_ROOT_DIR%=!"^) 1>&2
)
goto :eof

@rem input parameters: %1=file timestamp 1, %2=file timestamp 2
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

@rem Generated index page is %_TARGET_DOCS_DIR%\%_CRATE_NAME%\index.html
:doc
if not exist "%_TARGET_DOCS_DIR%" mkdir "%_TARGET_DOCS_DIR%"

set __SOURCE_FILES=
set __N=0
for /f "delims=" %%f in ('dir /b /s "%_SOURCE_DIR%\*.rs" 2^>NUL') do (
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
    echo %_ERROR_LABEL% Failed to generate HTML documentation into directory "!_TARGET_DOCS_DIR:%_ROOT_DIR%=!" 1>&2
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
    echo %_DEBUG_LABEL% "%_PELOOK_CMD%" %__PELOOK_OPTS% "!__EXE_FILE:%_ROOT_DIR%=!" 1>&2
    call "%_PELOOK_CMD%" %__PELOOK_OPTS% "%__EXE_FILE%"
) else (
    if %_VERBOSE%==1 echo Dump PE/COFF infos for executable !__EXE_FILE:%_ROOT_DIR%=! 1>&2
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
goto :eof

@rem output parameter: _DURATION
:duration
set __START=%~1
set __END=%~2

for /f "delims=" %%i in ('call "%_PWSH_CMD%" -c "$interval = New-TimeSpan -Start '%__START%' -End '%__END%'; Write-Host $interval"') do set _DURATION=%%i
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
if %_TIMER%==1 (
    for /f "delims=" %%i in ('call "%_PWSH_CMD%" -c "(Get-Date)"') do set __TIMER_END=%%i
    call :duration "%_TIMER_START%" "!__TIMER_END!"
    echo Total execution time: !_DURATION! 1>&2
)
if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
exit /b %_EXITCODE%
endlocal
