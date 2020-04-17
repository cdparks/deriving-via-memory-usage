MAKEFLAGS += --no-builtin-rules
.SUFFIXES:
.DEFAULT_GOAL := help

## Update local state with any remote changes
.PHONY: update
update:
	$(MAKE) update.stack update.tools

## Set up the compiler and project dependencies
.PHONY: update.stack
update.stack:
	stack setup
	stack build --fast --test --no-run-tests --dependencies-only

## Install additional tooling (e.g. HLint, brittany, etc)
.PHONY: update.tools
update.tools:
	stack build --copy-compiler-tool \
	  hlint \
	  stylish-haskell \
	  brittany

WORK_DIR_DERIVING_VIA=.stack-work-deriving-via
WORK_DIR_NO_DERIVING_VIA=.stack-work-no-deriving-via

STACK_DERIVING_VIA=STACK_WORK=$(WORK_DIR_DERIVING_VIA) stack
STACK_NO_DERIVING_VIA=STACK_WORK=$(WORK_DIR_NO_DERIVING_VIA) stack

GHC_OPTIONS_DERIVING_VIA=-DUSE_DERIVING_VIA -ddump-to-file -dshow-passes -ddump-timings -j +RTS -s -RTS
GHC_OPTIONS_NO_DERIVING_VIA=-ddump-to-file -ddump-timings -dshow-passes -j +RTS -s -RTS

## Build project using -XDerivingVia instances
.PHONY: deriving.via
deriving.via:
	$(STACK_DERIVING_VIA) clean oom
	$(STACK_DERIVING_VIA) build oom --ghc-options "$(GHC_OPTIONS_DERIVING_VIA)"

## Build project using regular Generic instances
.PHONY: no.deriving.via
no.deriving.via:
	$(STACK_NO_DERIVING_VIA) clean oom
	$(STACK_NO_DERIVING_VIA) build oom --ghc-options "$(GHC_OPTIONS_NO_DERIVING_VIA)"

.PHONY: table
table:
	python gen.py $(WORK_DIR_NO_DERIVING_VIA) $(WORK_DIR_DERIVING_VIA) > table.md

## Build both versions and update README
.PHONY: bench
bench:
	$(MAKE) no.deriving.via deriving.via table readme

## Update README.md from base.md and table.md
.PHONY: readme
readme:
	cat base.md table.md > README.md

# Produce help output for Makefile
#
# Doc blocks are signified with ##
#
# Sections can be added with ## -- Section --
#
# source: https://gist.github.com/prwhite/8168133#gistcomment-2749866
#
.PHONY: help
help:
	@printf "Usage\n";
	@awk '{ \
	  if ($$0 ~ /^.PHONY: [a-zA-Z\/\-\.\_0-9]+$$/) { \
	    helpCommand = substr($$0, index($$0, ":") + 2); \
	    if (helpMessage) { \
	      printf "\033[36m%-20s\033[0m %s\n", \
	        helpCommand, helpMessage; \
	      helpMessage = ""; \
	    } \
	  } else if ($$0 ~ /^[a-zA-Z\/\-\.\_0-9.]+:/) { \
	    helpCommand = substr($$0, 0, index($$0, ":")); \
	    if (helpMessage) { \
	      printf "\033[36m%-20s\033[0m %s\n", \
	        helpCommand, helpMessage; \
	      helpMessage = ""; \
	    } \
	  } else if ($$0 ~ /^##/) { \
	    if (helpMessage) { \
	      helpMessage = helpMessage"\n                     "substr($$0, 3); \
	    } else { \
	      helpMessage = substr($$0, 3); \
	    } \
	  } else { \
	    if (helpMessage) { \
	      print "\n                     "helpMessage"\n" \
	    } \
	    helpMessage = ""; \
	  } \
	}' \
	$(MAKEFILE_LIST)
