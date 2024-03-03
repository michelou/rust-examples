ifndef CARGO_HOME
$(error Variable CARGO_HOME is not set)
endif
ifndef MAVEN_HOME
$(error Variable MAVEN_HOME is not set)
endif

ifeq ($(OS),Windows_NT)
MVN        = $(subst \,/,$(MAVEN_HOME))/bin/mvn.cmd
RUSTC      = $(subst \,/,$(CARGO_HOME))/bin/rustc.exe
RUSTDOC    = $(subst \,/,$(CARGO_HOME))/bin/rustdoc.exe
LOCAL_REPO = $(subst \,/,$(USERPROFILE))/.m2/repository
PSEP       = ;
## $(MSYS_HOME)\usr\bin\{cp.exe, make.exe, wget.exe}
CP         = /usr/bin/cp.exe
ECHO       = /usr/bin/echo.exe
FIND       = /usr/bin/find.exe
MKDIR      = /usr/bin/mkdir.exe
RM         = /usr/bin/rm.exe
TOUCH      = /usr/bin/touch.exe
WGET       = /usr/bin/wget
else
MVN        = $(MAVEN_HOME)/bin/mvn
RUSTC      = $(CARGO_HOME)/bin/rustc
RUSTDOC    = $(CARGO_HOME)/bin/rustdoc
LOCAL_REPO = $(HOME)/.m2/repository
PSEP       = :
CP         = cp
ECHO       = echo
FIND       = find
MKDIR      = mkdir
MVN        = mvn
RM         = rm
TOUCH      = touch
WGET       = wget
endif
