Change History
**************


0.3.7 (2017-02-01)
==================

* fixed "make srcclean" on osx.
* ignore ``.env``.
* update conda version 4.3.

0.3.6 (2016-11-07)
==================

* update miniconda download url.
* update conda version.

0.3.5 (2016-10-20)
==================

* updated flake8 call.

0.3.4 (2016-10-19)
==================

* update-config target updated for docker.
* updated setuptools version.

0.3.3 (2016-10-18)
==================

* added pep8 checks.

0.3.2 (2016-10-12)
==================

* set conda priority-channel option.

0.3.1 (2016-07-22)
==================

* ignore failure of install target.
* clean build/ and dist/ folders.
* update conda version.

0.3.0 (2016-07-08)
==================

* pin only python=2.
* updated buildout=2.5.2 and setuptools=23.0.
* removed unused fetch_makefile from bootstrap.sh.
* addied ``envclean`` target to remove conda environment.
* removed PREFIX ... this handled in the buildout.cfg.
* ``make clean`` stops supervisor and removes also conda env.
* use app conda_pinned file.
* export target added.
* update miniconda install script.
* update conda.
* disabled channel_priority.
* customize with Makefile.config.

0.2.21 (2016-06-16)
==================

* removed unused fetch_makefile from bootstrap.sh

0.2.20 (2016-06-14)
===================

* run tests with pytest.
* removed geolinks pin
* help target is default
* added srclean target

0.2.19 (2016-04-15)
===================

* removed ioos default channel.
* add --yes flat to conda install.

0.2.18 (2016-04-11)
===================

* added cryptography conda package to makefile (#30)
* pinned cryptography.
* added pyyaml conda package.
* removed lxml pin.
* conda_env in makefile can be overwritten.

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
