# some stuff to help
# variable definitions

NAME := flibgolite

VERSION := $(shell git describe --tags --always --dirty)
GOVERSION := $(shell go version)
BUILDTIME := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

BUILD_GOOS ?= $(shell go env GOOS)
BUILD_GOARCH ?= $(shell go env GOARCH)

BUILDER_NAME := $(shell git config user.name)
ifndef BUILDER_NAME
$(error "You must set a user.name in your git configuration.")
endif

EMAIL := $(shell git config user.email)
ifndef EMAIL
$(error "You must set a user.email in your git configuration.")
endif

BUILDER := $(shell echo "${BUILDER_NAME} <${EMAIL}>")

LDFLAGS := -X 'main.version=$(VERSION)' \
           -X 'main.buildTime=$(BUILDTIME)' \
           -X 'main.builder=$(BUILDER)' \
           -X 'main.goversion=$(GOVERSION)'

CMD_SOURCES := $(shell find cmd -name main.go)
TARGETS := $(patsubst cmd/%/main.go,%,$(CMD_SOURCES))

all: check

check:

	@echo "NAME:" $(NAME)
	@echo
	@echo "VERSION:" $(VERSION)
	@echo "GOVERSION:" $(GOVERSION)
	@echo "BUILDTIME:" $(BUILDTIME)
	@echo
	@echo "BUILD_GOOS:" $(BUILD_GOOS)
	@echo "BUILD_GOARCH:" $(BUILD_GOARCH)
	@echo
	@echo "BUILDER_NAME:" $(BUILDER_NAME)
	@echo "EMAIL:" $(EMAIL)
	@echo "BUILDER:" $(BUILDER)
	@echo
	@echo "LDFLAGS:" $(LDFLAGS)
	@echo
	@echo "CMD_SOURCES:" $(CMD_SOURCES)
	@echo "TARGETS:" $(TARGETS)


build:
	go build -ldflags "$(LDFLAGS)" -o $(TARGETS) $(CMD_SOURCES)

.PHONY: all check build 