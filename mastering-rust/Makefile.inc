ifndef GIT_HOME
$(error Variable GIT_HOME is not set)
endif
ifndef CARGO_HOME
$(error Variable CARGO_HOME is not set)
endif

ifeq ($(OS),Windows_NT)
RUSTC      = $(subst \,/,$(CARGO_HOME))/bin/rustc.exe
TARGET_SUFFIX = .exe
TARGET_TRIPLE = $(shell arch)-pc-windows-msvc
EXE_SUFFIX = .exe
PSEP       = ;
CP         = $(subst \,/,$(GIT_HOME))/usr/bin/cp.exe
ECHO       = $(subst \,/,$(GIT_HOME))/usr/bin/echo.exe
## We grab Mingw version instead of C:\Windows\System32\find.exe
FIND       = $(subst \,/,$(GIT_HOME))/usr/bin/find.exe
MKDIR      = $(subst \,/,$(GIT_HOME))/usr/bin/mkdir.exe
RM         = $(subst \,/,$(GIT_HOME))/usr/bin/rm.exe
TOUCH      = $(subst \,/,$(GIT_HOME))/usr/bin/touch.exe
else
RUSTC      = rustc
TARGET_SUFFIX =
TARGET_TRIPLE = $(shell arch)-unknown-linux-gnu
EXE_SUFFIX = 
PSEP       = :
CP         = cp
ECHO       = echo
FIND       = find
MKDIR      = mkdir
RM         = rm
TOUCH      = touch
endif
