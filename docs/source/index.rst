.. Birdhouse Bootstrap documentation master file, created by
   sphinx-quickstart on Fri Mar 13 18:00:09 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. _introduction:

Introduction
============

`Birdhouse`_ uses `Buildout`_  to setup Web Processing Service applications like `Emu <http://emu.readthedocs.org/en/latest/>`_ and `Flyingpigeon <http://flyingpigeon.readthedocs.org/en/latest/>`_ with all configurations. 

All Birdhouse WPS applications have a common way to bootstrap the buildout installation. Part of this bootstrap process is to install system packages required by the application and to initialize the buildout installation (``bootstrap.py``, install Anaconda, ...). In addition there is a Makefile to simplify some tasks like cleaning the sources and running buildout.

The installation is using the Python distribution system `Anaconda`_ to maintain software dependencies. 
You may use an existing (shared, read-only access possible) Anaconda installation. For this set an environment variable to the location of your existing Anaconda, for example::

   $ export ANACONDA_HOME=/opt/anaconda

If Anaconda is not available then a minimal Anaconda will be installed during the installation processes in your home directory ``~/anaconda``. 

The installation process setups a conda environment named ``birdhouse``. All additional packages and configuration files are going into this conda environment. The location is ``~/.conda/envs/birdhouse``.

There are two main files in this project: ``bootstrap.sh`` and ``Makefile``.

bootstrap.sh
    A copy of this script needs to be in each Birdhouse application. It will fetch the current ``Makefile`` from the bootstrap github repo and install the essential system packages (``wget``, ``make``, ...) to start an installation.

Makefile
    This ``Makefile`` has targets to bootstrap and run buildout to install the application.

Getting Started
===============

.. toctree::
   :maxdepth: 2

   usage
   examples


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

.. _`Buildout`: http://buildout.org/
.. _`Anaconda`: http://www.continuum.io/
.. _`Birdhouse`: http://bird-house.github.io/

