#!/usr/bin/env bash
#
# Copyright (c) 2018-2025 Stéphane Micheloud
#
# Licensed under the MIT License.
#

##############################################################################
## Subroutines

getHome() {
    local source="${BASH_SOURCE[0]}"
    while [[ -h "$source" ]]; do
        local linked="$(readlink "$source")"
        local dir="$( cd -P $(dirname "$source") && cd -P $(dirname "$linked") && pwd )"
        source="$dir/$(basename "$linked")"
    done
    ( cd -P "$(dirname "$source")" && pwd )
}

debug() {
    local DEBUG_LABEL="[46m[DEBUG][0m"
    [[ $DEBUG -eq 1 ]] && echo "$DEBUG_LABEL $1" 1>&2
}

warning() {
    local WARNING_LABEL="[46m[WARNING][0m"
    echo "$WARNING_LABEL $1" 1>&2
}

error() {
    local ERROR_LABEL="[91mError:[0m"
    echo "$ERROR_LABEL $1" 1>&2
}

# use variables EXITCODE, TIMER_START
cleanup() {
    [[ $1 =~ ^[0-1]$ ]] && EXITCODE=$1

    if [[ $TIMER -eq 1 ]]; then
        local TIMER_END=$(date +'%s')
        local duration=$((TIMER_END - TIMER_START))
        echo "Total execution time: $(date -d @$duration +'%H:%M:%S')" 1>&2
    fi
    debug "EXITCODE=$EXITCODE"
    exit $EXITCODE
}

args() {
    [[ $# -eq 0 ]] && HELP=1 && return 1

    for arg in "$@"; do
        case "$arg" in
        ## options
        -debug)        DEBUG=1 ;;
        -edition:2015) EDITION=2015 ;;
        -edition:2018) EDITION=2018 ;;
        -edition:2021) EDITION=2021 ;;
        -edition:2024) EDITION=2024 ;;
        -help)         HELP=1 ;;
        -timer)        TIMER=1 ;;
        -verbose)      VERBOSE=1 ;;
        -*)
            error "Unknown option \"$arg\""
            EXITCODE=1 && return 0
            ;;
        ## subcommands
        clean)   CLEAN=1 ;;
        compile) COMPILE=1 ;;
        help)    HELP=1 ;;
        run)     COMPILE=1 && RUN=1 ;;
        *)
            error "Unknown subcommand \"$arg\""
            EXITCODE=1 && return 0
            ;;
        esac
    done
    debug "Options    : EDITION=$EDITION TARGET=$TARGET TIMER=$TIMER VERBOSE=$VERBOSE"
    debug "Subcommands: CLEAN=$CLEAN COMPILE=$COMPILE HELP=$HELP RUN=$RUN"
    debug "Variables  : CARGO_HOME=$CARGO_HOME"
    debug "Variables  : GIT_HOME=$GIT_HOME"
    debug "Variables  : MSYS_HOME=$MSYS_HOME"
    debug "Variables  : RUSTUP_ROOT=$RUSTUP_ROOT"
    # See http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
    [[ $TIMER -eq 1 ]] && TIMER_START=$(date +"%s")
}

help() {
    cat << EOS
Usage: $BASENAME { <option> | <subcommand> }

  Options:
    -debug       print commands executed by this script
    -timer       print total execution time
    -verbose     print progress messages

  Subcommands:
    clean        delete generated files
    compile      compile Rust source files
    help         print this help message
    run          execute the generated executable "$CRATE_NAME"
EOS
}

clean() {
    if [[ -d "$TARGET_DIR" ]]; then
        if [[ $DEBUG -eq 1 ]]; then
            debug "Delete directory \"$TARGET_DIR\""
        elif [[ $VERBOSE -eq 1 ]]; then
            echo "Delete directory \"${TARGET_DIR/$ROOT_DIR\//}\"" 1>&2
        fi
        rm -rf "$TARGET_DIR"
        [[ $? -eq 0 ]] || ( EXITCODE=1 && return 0 )
    fi
}

action_required() {
    local timestamp_file=$1
    local search_path=$2
    local search_pattern=$3
    local latest=
    for f in $(find $search_path -name $search_pattern 2>/dev/null); do
        [[ $f -nt $latest ]] && latest=$f
    done
    if [[ -z "$latest" ]]; then
        ## Do not compile if no source file
        echo 0
    elif [[ ! -f "$timestamp_file" ]]; then
        ## Do compile if timestamp file doesn't exist
        echo 1
    else
        ## Do compile if timestamp file is older than most recent source file
        local timestamp=$(stat -c %Y $timestamp_file)
        [[ $timestamp_file -nt $latest ]] && echo 1 || echo 0
    fi
}

compile() {
    [[ -d "$TARGET_DIR" ]] || mkdir -p "$TARGET_DIR"

    local timestamp_file="$TARGET_DIR/.latest-build"

    local is_required=0
    is_required="$(action_required "$timestamp_file" "$SOURCE_DIR/" "*.rs")"
    if [[ $is_required -eq 1 ]]; then
        compile_rust
        [[ $? -eq 0 ]] || ( EXITCODE=1 && return 0 )
    fi
    touch "$timestamp_file"
}

compile_rust() {
    local source_files=
    local n=0
    for f in $(find "$SOURCE_DIR/" -type f -name "*.rs" 2>/dev/null); do
        source_files="$source_files \"$f\""
        n=$((n + 1))
    done
    if [[ $n -eq 0 ]]; then
        warning "No Rust source file found"
        return 1
    fi
    local s=; [[ $n -gt 1 ]] && s="s"
    local n_files="$n Rust source file$s"
    if [[ $DEBUG -eq 1 ]]; then
        debug "\"$RUSTC_CMD\" $rustc_flags $source_files"
    elif [[ $VERBOSE -eq 1 ]]; then
        echo "Compile $n_files to directory \"${TARGET_DIR/$ROOT_DIR\//}\"" 1>&2
    fi
    local rust_crate_opts="--crate-name \"$CRATE_NAME\" --crate-type $CRATE_TYPE"
    local rustc_opts="$rust_crate_opts --edition $EDITION --out-dir \"$TARGET_DIR\" --target \"$TARGET_TRIPLE\""

    eval "\"$RUSTC_CMD\" $rustc_opts $source_files"
    if [[ $? -ne 0 ]]; then
        error "Failed to compile $n_files to directory \"${TARGET_DIR/$ROOT_DIR\//}\""
        cleanup 1
    fi
}

mixed_path() {
    if [[ -x "$CYGPATH_CMD" ]]; then
        $CYGPATH_CMD -am "$*"
    elif [[ $(($mingw + $msys)) -gt 0 ]]; then
        echo "$*" | sed 's|/|\\\\|g'
    else
        echo "$*"
    fi
}

doc() {
    echo "doc"
}

dump() {
    local exe_file="$TARGET_DIR/$CRATE_NAME$TARGET_EXT"
    if [[ ! -f "$exe_file" ]]; then
        error "Executable \"${exe_file/$ROOT_DIR\//}\" not found"
        cleanup 1
    fi
    local pelook_opts=
    if [[ $DEBUG -eq 1 ]]; then
        debug "$PELOOK_CMD $pelook_opts \"$exe_file\""
    else
        echo "$(exe_file/$ROOT_DIR\//)"
    fi
    if [[ $? -ne 0 ]]; then
        error "Failed to execute \"${exe_file/$ROOT_DIR\//}\"" 1>&2
        cleanup 1
    fi
}

run() {
    local exe_file="$TARGET_DIR/$CRATE_NAME$TARGET_EXT"
    if [[ ! -f "$exe_file" ]]; then
        error "Executable \"${exe_file/$ROOT_DIR\//}\" not found"
        cleanup 1
    fi
    if [[ $DEBUG -eq 1 ]]; then
        debug "$exe_file"
    elif [[ $VERBOSE -eq 1 ]]; then
        echo "Execute \"${exe_file/$ROOT_DIR\//}\"" 1>&2
    fi
    eval "$exe_file"
    if [[ $? -ne 0 ]]; then
        error "Failed to execute \"${exe_file/$ROOT_DIR\//}\"" 1>&2
        cleanup 1
    fi
}

##############################################################################
## Environment setup

BASENAME=$(basename "${BASH_SOURCE[0]}")

EXITCODE=0

ROOT_DIR="$(getHome)"

SOURCE_DIR="$ROOT_DIR/src"
TARGET_DIR="$ROOT_DIR/build"

## We refrain from using `true` and `false` which are Bash commands
## (see https://man7.org/linux/man-pages/man1/false.1.html)
CLEAN=0
CLEAN=0
COMPILE=0
DEBUG=0
HELP=0
RUN=0
TIMER=0
VERBOSE=0

COLOR_START="[32m"
COLOR_END="[0m"

cygwin=0
mingw=0
msys=0
darwin=0
case "$(uname -s)" in
    CYGWIN*) cygwin=1 ;;
    MINGW*)  mingw=1 ;;
    MSYS*)   msys=1 ;;
    Darwin*) darwin=1      
esac
unset CYGPATH_CMD
PSEP=":"
TARGET_EXT=
if [[ $(($cygwin + $mingw + $msys)) -gt 0 ]]; then
    CYGPATH_CMD="$(which cygpath 2>/dev/null)"
	PSEP=";"
    TARGET_EXT=".exe"
    USER_HOME="$USERPROFILE"
    MAKE_CMD="$(mixed_path $MSYS_HOME)/usr/bin/make.exe"
    RUSTC_CMD="$(mixed_path $CARGO_HOME)/bin/rustc.exe"
else
    USER_HOME="$HOME"
    MAKE_CMD=make
    RUSTC_CMD=rustc
fi

PROJECT_NAME="$(basename $ROOT_DIR)"
TARGET=msvc

EDITION=2021

CRATE_NAME=InnerFunction
CRATE_TYPE=bin

## General format: <arch>-<vendor>-<sys>-<abi> where
## arch   = x86_64, i686, arm, mips, etc.
## vendor = unknown, pc, etc.
## sys    = none, linux, windows, etc.
## abi    = gnu, android, elf, msvc, etc.
## Command: rustc --print target-list | findstr windows
TARGET_ARCH=x86_64
TARGET_VENDOR=pc
TARGET_SYS=windows
TARGET_TRIPLE=$TARGET_ARCH-$TARGET_VENDOR-$TARGET_SYS-$TARGET

args "$@"
[[ $EXITCODE -eq 0 ]] || cleanup 1

##############################################################################
## Main

[[ $HELP -eq 1 ]] && help && cleanup

if [[ $CLEAN -eq 1 ]]; then
    clean || cleanup 1
fi
if [[ $COMPILE -eq 1 ]]; then
    compile || cleanup 1
fi
if [[ $RUN -eq 1 ]]; then
    run || cleanup 1
fi
cleanup
