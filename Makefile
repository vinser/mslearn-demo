# some stuff to help
# variable definitions

NAME := flibgolite

VERSION := $(shell git describe --tags --always --dirty)
GOVERSION := $(shell go version | cut -c 12- | sed -e 's/ .*//g')
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

CMD_MAIN := $(shell find cmd -name main.go)
OUTPUT := $(patsubst cmd/%/main.go,%,$(CMD_MAIN))

all: build

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
	@echo "CMD_MAIN:" $(CMD_MAIN)
	@echo "OUTPUT:" $(OUTPUT)


build:
	go build -ldflags "$(LDFLAGS)" -o $(OUTPUT) $(CMD_MAIN)

xbuild:
	GOOS=linux GOARCH=arm64 go build -ldflags "$(LDFLAGS)" -o $(OUTPUT)-linux-arm64 $(CMD_MAIN)
	GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o $(OUTPUT)-linux-amd64 $(CMD_MAIN)
	GOOS=windows GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o $(OUTPUT)-windows-amd64.exe $(CMD_MAIN)

.PHONY: all check build xbuild