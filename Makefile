# user settings

DOWNLOAD_CACHE=downloads
ANACONDA_HOME=$(HOME)/anaconda

# guess OS (Linux, Darwin, ...)
OS_NAME := $(shell uname -s 2>/dev/null || echo "unknown")
CPU_ARCH := $(shell uname -m 2>/dev/null || uname -p 2>/dev/null || echo "unknown")

# choose anaconda installer depending on your OS
ANACONDA_URL = http://repo.continuum.io/miniconda
ifeq "$(OS_NAME)" "Linux"
FN := Miniconda-latest-Linux-x86_64.sh
else ifeq "$(OS_NAME)" "Darwin"
FN := Miniconda-3.7.0-MacOSX-x86_64.sh
else
FN := unknown
endif

# buildout files
BUILDOUT_FILES := parts eggs develop-eggs bin .installed.cfg .mr.developer.cfg *.egg-info bootstrap.py $(DOWNLOAD_CACHE)

# end of configuration

.DEFAULT_GOAL := help

.PHONY: all
all: clean install

.PHONY: help
help:
	@echo "make [target]\n"
	@echo "targets:\n"
	@echo "\t help \t\t- Prints this help message."
	@echo "\t info \t\t- Prints information about your system."
	@echo "\t install \t\t- Installs your application by running 'bin/buildout -c custom.cfg'."
	@echo "\t clean \t\t- Deletes all files that are created by running buildout."
	@echo "\t distclean \t- Removes *all* files that are not controlled by 'git'.\n\t\t\tWARNING: use it *only* if you know what you do!"
	@echo "\t all \t\t- Does a clean installation. Shortcut for 'make clean install.'"
	@echo "\t selfupdate \t- Updates this makefile."

.PHONY: info
info:
	@echo "Informations about your System:\n"
	@echo "\t OS_NAME \t= $(OS_NAME)"
	@echo "\t CPU_ARCH \t= $(CPU_ARCH)"
	@echo "\t Anaconda \t= $(FN)"
	@echo "\t Anaconda Home \t= $(ANACONDA_HOME)"
	@echo "\t DOWNLOAD_CACHE \t = ${DOWNLOAD_CACHE}"

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

.PHONY: install
install: bootstrap conda_pkgs
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

.PHONY: distclean
distclean: backup clean
	@echo "Cleaning distribution ..."
	@-git clean -dfx --exclude Makefile *.bak*

.PHONY: selfupdate
selfupdate:
	@echo "Update bootstrap.sh and Makefile ..."
	wget -q --no-check-certificate -O bootstrap.sh "https://raw.githubusercontent.com/bird-house/birdhousebuilder.bootstrap/master/bootstrap.sh"
	bash bootstrap.sh || echo "selfupdate failed!"

.PHONY: docker
docker:
	@echo "Building docker image ..."
	docker build -t test .


