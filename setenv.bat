@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging
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

set _CARGO_PATH=
set _GIT_PATH=

call :msys
if not %_EXITCODE%==0 goto :end

call :rust
if not %_EXITCODE%==0 goto end

call :git
if not %_EXITCODE%==0 goto end

goto end

@rem #########################################################################
@rem ## Subroutines

@rem output parameters: _DEBUG_LABEL, _ERROR_LABEL, _WARNING_LABEL
:env
set _BASENAME=%~n0
set _DRIVE_NAME=R
set "_ROOT_DIR=%~dp0"

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:
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
@rem output parameter: _BASH, _HELP, _VERBOSE
:args
set _BASH=0
set _HELP=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG goto args_done

if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-bash" ( set _BASH=1
    ) else if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option %__ARG% 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="help" ( set _HELP=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand %__ARG% 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto args_loop
:args_done
call :subst %_DRIVE_NAME% "%_ROOT_DIR%"
if not %_EXITCODE%==0 goto :eof
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options  : _HELP=%_HELP% _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Variables: _DRIVE_NAME=%_DRIVE_NAME% 1>&2
)
goto :eof

@rem input parameter(s): %1: drive letter, %2: path to be substituted
:subst
set __DRIVE_NAME=%~1
set "__GIVEN_PATH=%~2"

if not "%__DRIVE_NAME:~-1%"==":" set __DRIVE_NAME=%__DRIVE_NAME%:
if /i "%__DRIVE_NAME%"=="%__GIVEN_PATH:~0,2%" goto :eof

if "%__GIVEN_PATH:~-1%"=="\" set "__GIVEN_PATH=%__GIVEN_PATH:~0,-1%"
if not exist "%__GIVEN_PATH%" (
    echo %_ERROR_LABEL% Provided path does not exist ^(%__GIVEN_PATH%^) 1>&2
    set _EXITCODE=1
    goto :eof
)
for /f "tokens=1,2,*" %%f in ('subst ^| findstr /b "%__DRIVE_NAME%" 2^>NUL') do (
    set "__SUBST_PATH=%%h"
    if "!__SUBST_PATH!"=="!__GIVEN_PATH!" (
        set __MESSAGE=
        for /f %%i in ('subst ^| findstr /b "%__DRIVE_NAME%\"') do "set __MESSAGE=%%i"
        if defined __MESSAGE (
            if %_DEBUG%==1 ( echo %_DEBUG_LABEL% !__MESSAGE! 1>&2
            ) else if %_VERBOSE%==1 ( echo !__MESSAGE! 1>&2
            )
        )
        goto :eof
    )
)
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% subst "%__DRIVE_NAME%" "%__GIVEN_PATH%" 1>&2
) else if %_VERBOSE%==1 ( echo Assign path %__GIVEN_PATH% to drive %__DRIVE_NAME% 1>&2
)
subst "%__DRIVE_NAME%" "%__GIVEN_PATH%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to assigned drive %__DRIVE_NAME% to path 1>&2
    set _EXITCODE=1
    goto :eof
)
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
echo     %__BEG_O%-bash%__END%       start Git bash shell instead of Windows command prompt
echo     %__BEG_O%-debug%__END%      show commands executed by this script
echo     %__BEG_O%-verbose%__END%    display environment settings
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%help%__END%        display this help message
goto :eof

@rem output parameter(s): _MSYS_HOME
:msys
set _MSYS_HOME=

set __GCC_CMD=
for /f %%f in ('where gcc.exe 2^>NUL') do set __GCC_CMD=%%f
if defined __GCC_CMD (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using path of GNU Make executable found in PATH 1>&2
    for /f "delims=" %%i in ("%__GCC_CMD%") do set "__MAKE_BIN_DIR=%%~dpi"
    for %%f in ("!__MAKE_BIN_DIR!") do set "_MSYS_HOME=%%~dpf"
    @rem keep _MSYS_PATH undefined since executable already in path
    goto :eof
) else if defined MSYS_HOME (
    set "_MSYS_HOME=%MSYS_HOME%"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using environment variable MSYS_HOME 1>&2
) else (
    set "__PATH=%ProgramFiles%"
    for /f "delims=" %%f in ('dir /ad /b "!__PATH!\msys*" 2^>NUL') do set "_MSYS_HOME=!__PATH!\%%f"
    if not defined _MSYS_HOME (
        set __PATH=C:\opt
        for /f %%f in ('dir /ad /b "!__PATH!\msys*" 2^>NUL') do set "_MSYS_HOME=!__PATH!\%%f"
    )
)
if not exist "%_MSYS_HOME%\mingw64\bin\gcc.exe" (
    echo %_ERROR_LABEL% GNU C++ executable not found ^(%_MSYS_HOME%^) 1>&2
    set _MSYS_HOME=
    set _EXITCODE=1
    goto :eof
)
goto :eof

@rem output parameter(s): _CARGO_HOME, _CARGO_PATH
:rust
set _CARGO_HOME=
set _CARGO_PATH=

set __CARGO_CMD=
for /f %%f in ('where cargo.exe 2^>NUL') do set "__CARGO_CMD=%%f"
if defined __CARGO_CMD (
    for %%i in ("%__CARGO_CMD%") do set "__CARGO_BIN_DIR=%%~dpi"
    for %%f in ("!__CARGO_BIN_DIR!\.") do set "_CARGO_HOME=%%~dpf"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using path of Rust executable found in PATH 1>&2
    goto :eof
) else if defined CARGO_HOME (
    set "_CARGO_HOME=%CARGO_HOME%"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using environment variable CARGO_HOME 1>&2
) else if exist "%USERPROFILE%\.cargo\bin\cargo.exe" (
    set "_CARGO_HOME=%USERPROFILE%\.cargo"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using default Rust installation directory "!_CARGO_HOME!" 1>&2
)
if not exist "%_CARGO_HOME%\bin\cargo.exe" (
    echo %_ERROR_LABEL% Cargo executable not found ^(%_CARGO_HOME%^) 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_CARGO_PATH=;%_CARGO_HOME%\bin"
goto :eof

@rem output parameters: _GIT_HOME, _GIT_PATH
:git
set _GIT_HOME=
set _GIT_PATH=

set __GIT_CMD=
for /f %%f in ('where git.exe 2^>NUL') do set "__GIT_CMD=%%f"
if defined __GIT_CMD (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using path of Git executable found in PATH 1>&2
    for %%i in ("%__GIT_CMD%") do set "__GIT_BIN_DIR=%%~dpi"
    for %%f in ("!__GIT_BIN_DIR!\.") do set "_GIT_HOME=%%~dpf"
    @rem Executable git.exe is present both in bin\ and \mingw64\bin\
    if not "!_GIT_HOME:mingw=!"=="!_GIT_HOME!" (
        for %%f in ("!_GIT_HOME!.") do set "_GIT_HOME=%%~dpf"
    )
    @rem keep _GIT_PATH undefined since executable already in path
    goto :eof
) else if defined GIT_HOME (
    set "_GIT_HOME=%GIT_HOME%"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using environment variable GIT_HOME
) else (
    set __PATH=C:\opt
    if exist "!__PATH!\Git\" ( set "_GIT_HOME=!__PATH!\Git"
    ) else (
        for /f %%f in ('dir /ad /b "!__PATH!\Git*" 2^>NUL') do set "_GIT_HOME=!__PATH!\%%f"
        if not defined _GIT_HOME (
            set "__PATH=%ProgramFiles%"
            for /f %%f in ('dir /ad /b "!__PATH!\Git*" 2^>NUL') do set "_GIT_HOME=!__PATH!\%%f"
        )
    )
    if defined _GIT_HOME (
        if %_DEBUG%==1 echo %_DEBUG_LABEL% Using default Git installation directory "!_GIT_HOME!" 1>&2
    )
)
if not exist "%_GIT_HOME%\bin\git.exe" (
    echo %_ERROR_LABEL% Git executable not found ^(%_GIT_HOME%^) 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_GIT_PATH=;%_GIT_HOME%\bin;%_GIT_HOME%\mingw64\bin;%_GIT_HOME%\usr\bin"
goto :eof

:print_env
set __VERBOSE=%1
set "__VERSIONS_LINE1=  "
set "__VERSIONS_LINE2=  "
set __WHERE_ARGS=
where /q "%CARGO_HOME%\bin:cargo.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%CARGO_HOME%\bin\cargo.exe" --version') do set "__VERSIONS_LINE1=%__VERSIONS_LINE1% cargo %%j,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%CARGO_HOME%\bin:cargo.exe"
)
where /q "%CARGO_HOME%\bin:rustc.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%CARGO_HOME%\bin\rustc.exe" --version') do set "__VERSIONS_LINE1=%__VERSIONS_LINE1% rustc %%j,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%CARGO_HOME%\bin:rustc.exe"
)
where /q "%CARGO_HOME%\bin:rustfmt.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%CARGO_HOME%\bin\rustfmt.exe" --version') do set "__VERSIONS_LINE1=%__VERSIONS_LINE1% rustfmt %%j,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%CARGO_HOME%\bin:rustfmt.exe"
)
where /q "%CARGO_HOME%\bin:rustup.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%CARGO_HOME%\bin\rustup.exe" --version 2^>NUL') do set "__VERSIONS_LINE1=%__VERSIONS_LINE1% rustup %%j,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%CARGO_HOME%\bin:rustup.exe"
)
set "__BIN_DIR=%~dp0bin"
where /q "%__BIN_DIR%:pelook.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1-3,4,*" %%i in ('"%__BIN_DIR%\pelook.exe" /? ^| findstr /b PE') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% pelook %%l,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%__BIN_DIR%:pelook.exe"
)
where /q "%GIT_HOME%\bin:git.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%GIT_HOME%\bin\git.exe" --version') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% git %%k,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GIT_HOME%\bin:git.exe"
)
where /q "%GIT_HOME%\usr\bin:diff.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1-3,*" %%i in ('"%GIT_HOME%\usr\bin\diff.exe" --version ^| findstr diff') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% diff %%l,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GIT_HOME%\usr\bin:diff.exe"
)
where "%GIT_HOME%\bin:bash.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1-3,4,*" %%i in ('"%GIT_HOME%\bin\bash.exe" --version ^| findstr bash') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% bash %%l"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GIT_HOME%\bin:bash.exe"
)
echo Tool versions:
echo %__VERSIONS_LINE1%
echo %__VERSIONS_LINE2%
if %__VERBOSE%==1 (
    echo Tool paths: 1>&2
    for /f "tokens=*" %%p in ('where %__WHERE_ARGS%') do echo    %%p 1>&2
    echo Environment variables: 1>&2
    if defined CARGO_HOME echo    "CARGO_HOME=%CARGO_HOME%" 1>&2
    if defined GIT_HOME echo    "GIT_HOME=%GIT_HOME%" 1>&2
    if defined MSYS_HOME echo    "MSYS_HOME=%MSYS_HOME%" 1>&2
    if defined RUSTUP_HOME echo    "RUSTUP_HOME=%RUSTUP_HOME%" 1>&2
)
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
endlocal & (
    if %_EXITCODE%==0 (
        if not defined CARGO_HOME set "CARGO_HOME=%_CARGO_HOME%"
        if not defined GIT_HOME set "GIT_HOME=%_GIT_HOME%"
        if not defined MSYS_HOME set "MSYS_HOME=%_MSYS_HOME%"
        if not defined RUSTUP_HOME set "RUSTUP_HOME=%USERPROFILE%\.rustup"
        set "PATH=%PATH%%_CARGO_PATH%%_GIT_PATH%;%~dp0bin"
        call :print_env %_VERBOSE%
        if %_BASH%==1 (
            @rem see https://conemu.github.io/en/GitForWindows.html
            if %_DEBUG%==1 echo %_DEBUG_LABEL% %GIT_HOME%\usr\bin\bash.exe --login 1>&2
            cmd.exe /c "%GIT_HOME%\usr\bin\bash.exe --login"
        ) else if not "%CD:~0,2%"=="%_DRIVE_NAME%:" (
            if %_DEBUG%==1 echo %_DEBUG_LABEL% cd /d %_DRIVE_NAME%: 1>&2
            cd /d %_DRIVE_NAME%:
        )
    )
    if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
    for /f "delims==" %%i in ('set ^| findstr /b "_"') do set %%i=
)