EDITION ?= 2018
ifeq ($(filter $(EDITION), 2015 2018 2021 2024),)
   $(error Legal values for variable `EDITION` are: 2015,2018,2021)
endif

include ../Makefile.inc

SOURCE_DIR  = src
TARGET_DIR  = target

CRATE_NAME   = arrays
CRATE_TYPE   = bin

# Lint levels: -A (allow), -W (warning), -D (deny), -F (forbid)
# See https://doc.rust-lang.org/rustc/lints/levels.html
RUST_LINT_OPTS  =
RUST_CRATE_OPTS = --crate-name "$(CRATE_NAME)" --crate-type $(CRATE_TYPE)

##############################################################################
## main rules

SOURCES   = $(shell $(FIND) "$(SOURCE_DIR)" -type f -name "*.rs" 2>/dev/null)
TARGET    = $(TARGET_DIR)/$(CRATE_NAME)$(TARGET_SUFFIX)

RUSTC_OPTS = $(RUST_LINT_OPTS) $(RUST_CRATE_OPTS) --edition $(EDITION) --out-dir "$(TARGET_DIR)" --target "$(TARGET_TRIPLE)"

all: build

build: $(TARGET)

$(TARGET): $(SOURCES)
	[ -d "$(TARGET_DIR)" ] || "$(MKDIR)" -p "$(TARGET_DIR)"
	"$(RUSTC)" $(RUSTC_OPTS) $<

clean:
	"$(RM)" -rf "$(TARGET_DIR)"
	"$(RM)" -f "Cargo.lock"

run: build
ifeq ($(OS),Windows_NT)
	$(subst /,\,$(TARGET))
else
	$(TARGET)
endif

help:
	@$(ECHO) "Usage: make all|build|clean|help|run"
	@$(ECHO) ""
	@$(ECHO) "  Subcommands:"
	@$(ECHO) "    all    alias for build"
	@$(ECHO) "    build  compile Rust source files"
	@$(ECHO) "    clean  delete generated files"
	@$(ECHO) "    help   display this help message"
	@$(ECHO) "    run    execute main program \"$(CRATE_NAME)$(TARGET_SUFFIX)\""

##############################################################################
## phony

.PHONY: all build clean help run
