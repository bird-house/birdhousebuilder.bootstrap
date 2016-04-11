Change History
**************

0.2.18 (2016-04-11)
===================

* added cryptography conda package to makefile (#30)
* added pyyaml conda package.
* removed lxml pin.

0.2.17 (2016-04-07)
===================

* "make clean" removes now .pyc files.
* .gitignore will be updated on "make selfupdate".
* pinned lxml=3.5.0 (needed by pywps). 
* added fortran/gcc generated files to .gitignore.

0.2.8 (2015-09-22)
==================

* make update: run install in offline mode (no internet connection)
* boostrap.sh: install sudo if missing

0.2.7 (2015-09-16)
==================

* make test: skip tests with testdata attribute.

0.2.6 (2015-08-05)
==================

* use CONDA_ENVS_DIR variable to overwrite conda envs directory.

0.2.5 (2015-07-06)
==================

* update Makefile to latest buildout 2.4.0.
* using curl in Makefile.

0.2.4 (2015-06-29)
==================

* add generated password to custom.cfg
* fixed "make sysinstall" (don't update bootstrap.sh with wget)

0.2.3 (2015-06-25)
==================

* added "make passwd" for phoenix password generation.
* removed pinned versions.

0.2.2 (2015-04-13)
==================

* update boostrap.sh on selfupdate (even if it exists).
* fixed bootstrap.sh for centos builds.
* buildout bootstrap with pinned setuptools=14.3, zc.buildout=2.3.1
* using setuptools and curl from anaconda

0.2.1 (2015-02-25)
==================

* updated docs
* re-added test targets ...  

0.2.0 (2015-02-24)
==================

* now possible to use shared anaconda installation.
* install into birdhouse conda env.
* separation of anaconda-home and install prefix.
* fixed ssl verify error with conda update:
https://github.com/conda/conda/issues/1166 

0.1.2 (2015-02-18)
==================

* make target testall added
* make target test: skip slow tests
* update conda-meta/pinned
* fixed builout bootstrap: using setuptools 7.0
* doc target added to makefile (sphinx build)

0.1.1 (2014-11-13)
==================

* updated to buildout 2.x
* using RELEASE variable in makefile

0.1.0 (2014-11-12)
==================

* Initial Release.
