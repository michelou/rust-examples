##
## Copyright (c) 2018-2025 Stéphane Micheloud
##
## Licensed under the MIT License.
##
##############################################################################

include ../Makefile.inc

PROJECT_NAME ?= $(shell basename $(CURDIR))

SOURCE_DIR  = src
TARGET_DIR  = target
TARGET_DOCS_DIR = $(TARGET_DIR)/docs

##############################################################################
## main rules

SOURCES = $(wildcard $(SOURCE_DIR)/main/rust/main.rs)
TARGET  = $(TARGET_DIR)/$(PROJECT_NAME)$(TARGET_EXT)

## General format: <arch>-<vendor>-<sys>-<abi>
## rustc --print target-list
TARGET_TRIPLE=x86_64-pc-windows-msvc

CRATE_NAME=$(PROJECT_NAME)
EDITION=2018

## Lint levels: -A (allow), -W (warning), -D (deny), -F (forbid)
## See https://doc.rust-lang.org/rustc/lints/levels.html
RUST_LINT_OPTS=
RUST_CRATE_OPTS=--crate-name "$(CRATE_NAME)" --crate-type bin
RUST_DEPS_OPTS=

RUSTC_OPTS=$(RUST_LINT_OPTS) $(RUST_CRATE_OPTS) --edition $(EDITION) --out-dir "$(TARGET_DIR)" --target "$(TARGET_TRIPLE)"

all: build

build: $(TARGET)

$(TARGET): $(SOURCES)
	[ -d "$(TARGET_DIR)" ] || "$(MKDIR)" -p "$(TARGET_DIR)"
	"$(RUSTC)" $(RUSTC_OPTS) $(SOURCES) $(RUST_DEPS_OPTS)

clean:
	"$(RM)" -rf "$(TARGET_DIR)"

compile: build

run: build
	$(TARGET)

help:
	@$(ECHO) "Usage: make all|build|clean|doc|help|run"
	@$(ECHO) ""
	@$(ECHO) "  Subcommands:"
	@$(ECHO) "    all    alias for build"
	@$(ECHO) "    build  compile Java/Scala source files"
	@$(ECHO) "    clean  delete generated files"
	@$(ECHO) "    doc    generate HTML documentation"
	@$(ECHO) "    help   print this help message"
	@$(ECHO) "    run    execute main program \"$(TARGET)\""

##############################################################################
## doc rules

RUSTDOC_OPTS=

doc:
	[ -d "$(TARGET_DOCS_DIR)" ] || $(MKDIR) -p "$(TARGET_DOCS_DIR)"
	"$(RUSTDOC)" $(RUSTDOC_OPTS)

##############################################################################
## lint rules

lint:
	"$(CARGO)" clippy

##############################################################################
## phony

.PHONY: all build clean doc help lint run

.SUFFIXES:
.SUFFIXES: .exe .rs
