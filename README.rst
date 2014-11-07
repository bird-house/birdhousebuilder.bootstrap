**************************
birdhousebuilder.bootstrap
**************************

.. contents::

Introduction
************

All Birdhouse WPS applications have a common way to bootstrap the buildout installation. Part of this bootstrap process is to install system packages required by the application and to initialize the buildout installation (bootstrap.py, install Anaconda, ...). In addition there is a Makefile to simplify some tasks like cleaning the sources and running buildout.

There are two main files in this project: ``buildout.sh`` and ``Makefile``.

``buildout.sh``
    A copy of this script needs to be in each Birdhouse WPS application. It will fetch the current ``Makefile`` from the bootstrap github repo and install the essential system packages (``wget``, ``make``, ...) to start an installation.

``Makefile``
    This ``Makefile`` has targets to bootstrap and run buildout to install the application.

Usage of buildout.sh
********************

Run ``buildout.sh -h`` in your Birdhouse application root folder to see the available options::

   $ cd my-wps-app
   $ bash buildout.sh -h

This will output::

   Usage : bootstrap.sh [option]

   Options:
        -h   - Print this help message.
        -i   - Installs required system packages for Birdhouse build. You *need* 'sudo' priviliges!"
        -u   - Updates Makefile for Birdhouse build. Python needs to be installed."
        -b   - Both system packages will be installed (-i) and Makefile will be updated (-u). Default."


Usage of Makefile
*****************  

Run ``make help`` in your Birdhouse application root folder to see the available options::

   $ cd my-wps-app
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


