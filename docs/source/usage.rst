.. _usage:

Usage
=====

bootstrap.sh
------------

Run ``bootstrap.sh -h`` in your Birdhouse application root folder to see the available options::

   $ cd MyApp
   $ bash bootstrap.sh -h

This will output::

   Usage : bootstrap.sh [option]

   Options:
        -h   - Print this help message.
        -i   - Installs required system packages for Birdhouse build. You *need* 'sudo' priviliges!"
        -u   - Updates Makefile for Birdhouse build. Python needs to be installed."
        -b   - Both system packages will be installed (-i) and Makefile will be updated (-u). Default."


.. _makefile:

Makefile
-------- 

Run ``make help`` in your Birdhouse application root folder to see the available options::

   $ cd MyApp
   $ make help

This will output::

    make [target]

    targets:

         all            - Does a complete installation. Shortcut for 'make sysinstall clean install.' (Default)
         help           - Prints this help message.
         version        - Prints version number of this Makefile.
         info           - Prints information about your system.
         install        - Installs your application by running 'bin/buildout -c custom.cfg'.
         test           - Run tests (but skip long running tests).
         testall        - Run all tests (including long running tests).
         clean          - Deletes all files that are created by running buildout.
         distclean      - Removes *all* files that are not controlled by 'git'.
                        WARNING: use it *only* if you know what you do!
         sysinstall     - Installs system packages from requirements.sh. You can also call 'bash requirements.sh' directly.
         selfupdate     - Updates this Makefile.

    Supervisor targets:

         start          - Starts supervisor service: /home/pingu/.conda/envs/birdhouse/etc/init.d/supervisord start
         stop           - Stops supervisor service: /home/pingu/.conda/envs/birdhouse/etc/init.d/supervisord stop
         restart        - Restarts supervisor service: /home/pingu/.conda/envs/birdhouse/etc/init.d/supervisord restart
         status         - Supervisor status: /home/pingu/.conda/envs/birdhouse/bin/supervisorctl status

    Docker targets:

         Dockerfile     - Generates a Dockerfile for this application.
         dockerbuild    - Build a docker image for this application.
