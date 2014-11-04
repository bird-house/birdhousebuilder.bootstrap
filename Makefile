# Application
APP_ROOT := $(CURDIR)
APP_NAME := $(shell basename $(APP_ROOT))

# guess OS (Linux, Darwin, ...)
OS_NAME := $(shell uname -s 2>/dev/null || echo "unknown")
CPU_ARCH := $(shell uname -m 2>/dev/null || uname -p 2>/dev/null || echo "unknown")

# Anaconda 
ANACONDA_HOME := $(HOME)/anaconda

# choose anaconda installer depending on your OS
ANACONDA_URL = http://repo.continuum.io/miniconda
ifeq "$(OS_NAME)" "Linux"
FN := Miniconda-latest-Linux-x86_64.sh
else ifeq "$(OS_NAME)" "Darwin"
FN := Miniconda-3.7.0-MacOSX-x86_64.sh
else
FN := unknown
endif

# Buildout files and folders
DOWNLOAD_CACHE := $(APP_ROOT)/downloads
BUILDOUT_FILES := parts eggs develop-eggs bin .installed.cfg .mr.developer.cfg *.egg-info bootstrap.py $(DOWNLOAD_CACHE)

# Docker
DOCKER_IMAGE := $(APP_NAME)
DOCKER_CONTAINER := $(APP_NAME)

# end of configuration

.DEFAULT_GOAL := help

.PHONY: all
all: clean build

.PHONY: help
help:
	@echo "make [target]\n"
	@echo "targets:\n"
	@echo "\t help        \t- Prints this help message (Default)."
	@echo "\t info        \t- Prints information about your system."
	@echo "\t build       \t- Builds your application by running 'bin/buildout -c custom.cfg'."
	@echo "\t clean       \t- Deletes all files that are created by running buildout."
	@echo "\t distclean   \t- Removes *all* files that are not controlled by 'git'.\n\t\tWARNING: use it *only* if you know what you do!"
	@echo "\t all         \t- Does a clean build. Shortcut for 'make clean build.'"
	@echo "\t sysinstall  \t- Installs system packages from requirements.sh. You can also call 'bash requirements.sh' directly."
	@echo "\t dockerbuild \t- Build a docker image for this application."
	@echo "\t selfupdate  \t- Updates this makefile."

.PHONY: info
info:
	@echo "Informations about your System:\n"
	@echo "\t OS_NAME          \t= $(OS_NAME)"
	@echo "\t CPU_ARCH         \t= $(CPU_ARCH)"
	@echo "\t Anaconda         \t= $(FN)"
	@echo "\t Anaconda Home    \t= $(ANACONDA_HOME)"
	@echo "\t APP_NAME         \t= $(APP_NAME)"
	@echo "\t APP_ROOT         \t= $(APP_ROOT)"
	@echo "\t DOWNLOAD_CACHE   \t= $(DOWNLOAD_CACHE)"
	@echo "\t DOCKER_IMAGE     \t= $(DOCKER_IMAGE)"
	@echo "\t DOCKER_CONTAINER \t= $(DOCKER_CONTAINER)"

requirements.sh:
	@echo "Setup default requirements.sh ..."
	@wget -q --no-check-certificate -O requirements.sh "https://raw.githubusercontent.com/bird-house/birdhousebuilder.bootstrap/master/requirements.sh"

.PHONY: sysinstall
sysinstall: requirements.sh
	@echo "Installing system packages for your application ..."
	@bash ./requirements.sh

custom.cfg:
	@echo "Using custom.cfg for buildout ..."
	@test -f custom.cfg || cp -v custom.cfg.example custom.cfg

.PHONY: downloads
downloads:
	@echo "Using DOWNLOAD_CACHE = ${DOWNLOAD_CACHE}"
	@test -d $(DOWNLOAD_CACHE) || mkdir -v -p $(DOWNLOAD_CACHE)

.PHONY: init
init: custom.cfg downloads

bootstrap.py:
	@test -f boostrap.py || wget -O bootstrap.py http://downloads.buildout.org/1/bootstrap.py

.PHONY: bootstrap
bootstrap: init anaconda bootstrap.py
	@echo "Bootstrap buildout ..."
	$(ANACONDA_HOME)/bin/python bootstrap.py -c custom.cfg

.PHONY: anaconda
anaconda:
	@echo "Installing Anaconda ..."
	@test -d $(ANACONDA_HOME) || wget -q -c -O "$(DOWNLOAD_CACHE)/$(FN)" $(ANACONDA_URL)/$(FN)
	@test -d $(ANACONDA_HOME) || bash "$(DOWNLOAD_CACHE)/$(FN)" -b -p $(ANACONDA_HOME)   
	@echo "Add '$(ANACONDA_HOME)/bin' to your PATH variable in '.bashrc'."

.PHONY: conda_pkgs
conda_pkgs: anaconda
	"$(ANACONDA_HOME)/bin/conda" install --yes pyopenssl

.PHONY: build
build: bootstrap conda_pkgs
	@echo "Installing application with buildout ..."
	bin/buildout -c custom.cfg

.PHONY: clean
clean:
	@echo "Cleaning buildout files ..."
	@-for i in $(BUILDOUT_FILES); do \
            test -e $$i && rm -v -rf $$i; \
        done

.PHONY: backup
backup:
	@echo "Backup custom config ..." 
	@-test -f custom.cfg && cp -v --update --backup=numbered --suffix=.bak custom.cfg custom.cfg.bak
	@echo "Backup Makefile ..."
	@-test -f Makefile && cp -v --update --backup=numbered --suffix=.bak Makefile Makefile.bak
	@echo "Backup Dockerfile ..."
	@-test -f Dockerfile && cp -v --update --backup=numbered --suffix=.bak Dockerfile Dockerfile.bak

.PHONY: distclean
distclean: backup clean
	@echo "Cleaning distribution ..."
	@-git clean -dfx --exclude=*.bak

.PHONY: selfupdate
selfupdate: backup
	@echo "Update bootstrap.sh ..."
	@wget -q --no-check-certificate -O bootstrap.sh "https://raw.githubusercontent.com/bird-house/birdhousebuilder.bootstrap/master/bootstrap.sh"
	@echo "Update Makefile ..."
	@bash bootstrap.sh -u

.dockerignore:
	@echo "Update .dockerignore ..."
	@wget -q --no-check-certificate -O .dockerignore "https://raw.githubusercontent.com/bird-house/birdhousebuilder.bootstrap/master/dot_dockerignore"

Dockerfile:
	@echo "Update Dockerfile ..."
	@wget -q --no-check-certificate -O Dockerfile "https://raw.githubusercontent.com/bird-house/birdhousebuilder.bootstrap/master/Dockerfile"

.PHONY: dockerbuild
dockerbuild: Dockerfile .dockerignore
	@echo "Building docker image ..."
	docker build --rm -t $(DOCKER_IMAGE) .

.PHONY: dockerrun
dockerrun: dockerbuild
	@echo "Run docker image ..."
	docker run -i -t -p 9001:9001 --name=$(DOCKER_CONTAINER) $(DOCKER_IMAGE) /bin/bash
