**************************
birdhousebuilder.bootstrap
**************************

.. contents::

Introduction
************

All Birdhouse WPS applications have a common way to bootstrap the buildout installation. Part of this bootstrap process is to install system packages required by the application and to initialize the buildout installation (bootstrap.py, install Anaconda, ...). In addition there is a Makefile to simplify some tasks like cleaning the sources and running buildout.

There are two main files in this project: ``buildout.sh`` and ``Makefile``.

buildout.sh
    A copy of this script needs to be in each Birdhouse WPS application. It will fetch the current ``Makefile`` from the bootstrap github repo and install the essential system packages (``wget``, ``make``, ...) to start an installation.

Makefile
    This ``Makefile`` has targets to bootstrap and run buildout to install the application.

Usage
*****

buildout.sh
===========

Run ``buildout.sh -h`` in your Birdhouse application root folder to see the available options::

   $ cd MyApp
   $ bash buildout.sh -h

This will output::

   Usage : bootstrap.sh [option]

   Options:
        -h   - Print this help message.
        -i   - Installs required system packages for Birdhouse build. You *need* 'sudo' priviliges!"
        -u   - Updates Makefile for Birdhouse build. Python needs to be installed."
        -b   - Both system packages will be installed (-i) and Makefile will be updated (-u). Default."


Makefile
========  

Run ``make help`` in your Birdhouse application root folder to see the available options::

   $ cd MyApp
   $ make help

This will output::

   make [target]

   targets:

         all            - Does a complete installation. Shortcut for 'make sysinstall clean install.' (Default)
         help           - Prints this help message.
         info           - Prints information about your system.
         install        - Installs your application by running 'bin/buildout -c custom.cfg'.
         clean          - Deletes all files that are created by running buildout.
         distclean      - Removes *all* files that are not controlled by 'git'.
                WARNING: use it *only* if you know what you do!
         sysinstall     - Installs system packages from requirements.sh. You can also call 'bash requirements.sh' directly.
         Dockerfile     - Generates a Dockerfile for this application.
         dockerbuild    - Build a docker image for this application.
         selfupdate     - Updates this makefile.


Examples
********


Just build my app ...
=====================

For convenience applications come already with a Makefile. So, the simplest way to build the application is::

   $ git clone https://github.com/bird-house/MyApp.git 
   $ cd MyApp
   $ make


Just rebuild my app ...
=======================

Your application is checked out and system requirements are already installed::


   $ cd MyApp
   $ make install

To get the latest eggs from pypi you should run::

   $ make clean install

If you have changed system requirements in your ``requirements.sh`` file::

   $ cd MyApp
   $ vim requirements.sh  # add system packages for your application
   $ make sysinstall      # install requirements
   $ make clean install   # run a clean build

Install my app with an unprivileged user ...
============================================

Your installation user has no ``sudo`` rights::

   nobody$ git clone https://github.com/bird-house/MyApp.git 
   nobody$ cd MyApp

Run ``make sysinstall`` with a user who has sudo rights to install system requirements::

   admin$ make sysinstall

The application build itself does not need sudo rights::

   nobody$ make clean install

Update to the latest Makefile ...
=================================

Just do::

   $ make selfupdate

There is no *make* on my system
===============================

Just do::

   $ bash boostrap.sh # will install make and wget
   $ make


Generate a docker image for my app
==================================

Just do::

   $ make dockerbuild

Just generate a Dockerfile ...
==============================

Just do::

   $ make Dockerfile

You can change the default docker base image in your ``custom.cfg``::

   $ vim custom.cfg
   [docker]
   image-name = centos
   image-version = centos6
   maintainer = MyApp
   
