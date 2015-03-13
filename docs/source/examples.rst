.. _examples:

Examples
========


Just build my app
-----------------

For convenience applications come already with a Makefile. So, the simplest way to build the application is::

   $ git clone https://github.com/bird-house/MyApp.git 
   $ cd MyApp
   $ make

Start the application with::

   $ make start    # start supervisor
   $ make status   # check status

Check the log files for errors::

   $ cd ~/.conda/envs/birdhouse
   $ ls var/log/

Generated config files are in etc/::

   $ cd ~/.conda/envs/birdhouse
   $ ls etc/   

Just rebuild my app
-------------------

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

Restart your application::

   $ make restart
   $ make status

Use a shared Anaconda installation
----------------------------------

You can use an existing Anaconda installation which might be read-only and shared with others. For this set an environmet variable to point to this shared Anaconda location::

   $ export ANACONDA_HOME=/opt/anaconda

The run your installation again::

   $ make clean install

Use my birdhouse conda environment
----------------------------------

To activate the birdhouse environment do the following::

   $ source activate birdhouse

Read the conda docs for further information:

http://conda.pydata.org/docs/faq.html#env-creating

Keep my data at a save place
----------------------------

By default all configuration and data files are stored below the installation root folder in the conda environment ``birdhouse``::

  $ cd ~/.conda/envs/birdhouse
  $ ls 
  bin  conda-meta  etc  Examples  html  include  lib  libexec  man  opt  plugins  sbin  share  ssl  var

Configuration files are in the ``etc/`` folder. Data (databases, caches, ...) and log files are in the ``var/`` folder. 

If you want to keep your data files in a location of your choice (the birdhouse location might change in the future ...) then move the ``var/`` folder to that place and replace it with a softlink::

  $ cd ~/.conda/envs/birdhouse
  $ mv var /home/myself/Shared/var
  $ ln -s /home/myself/Shared/var .

If you use a new ``var/`` folder (contains no birdhouse files) then you need to run the installation again::

  $ cd ~/.conda/envs/birdhouse
  $ mv var var.old
  $ ln -s /home/myself/Shared/var .
  # run installation ...
  $ cd ~/sandbox/bridhouse/myapp
  $ make clean install

attention:: Make sure you have write access to the ``var/`` folder.
  

Install my app with an unprivileged user
----------------------------------------

Your installation user has no ``sudo`` rights::

   nobody$ git clone https://github.com/bird-house/MyApp.git 
   nobody$ cd MyApp

Run ``make sysinstall`` with a user who has sudo rights to install system requirements::

   admin$ make sysinstall

The application build itself does not need sudo rights::

   nobody$ make clean install
   nobody$ make start
   nobody$ make status

Update to the latest Makefile ...
---------------------------------

Just do::

   $ make selfupdate

There is no *make* on my system
-------------------------------

Just do::

   $ bash boostrap.sh # will install make and wget
   $ make


Generate a docker image for my app
----------------------------------

Just do::

   $ make dockerbuild

Just generate a Dockerfile ...
------------------------------

Just do::

   $ make Dockerfile

You can change the default docker base image in your ``custom.cfg``::

   $ vim custom.cfg
   [docker]
   image-name = centos
   image-version = centos6
   maintainer = MyApp
   
