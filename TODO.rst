Todo List
*********

* enable start/stop of nginx/supervisord on ubuntu/centos

http://www.abhigupta.com/2010/06/how-to-auto-start-services-on-boot-in-centos-redhat/

* buildout with site-packages:
  Add an --allow-site-packges option to bootstrap.py, defaulting to False. If the value is false, strip any "site packages" (as defined by the site module) from sys.path before attempting to import setuptools / pkg_resources.

* collect common buildout configs ... may used remotely or copy via selfupdate.
* use buildout for requirements (buildout 2.x can decide between dists ...)
* need test data for unit tests. where to store test data: 
  local mercurial/largefile, git-annex, docker data-only image?
* add "make test" to run unit tests
* boostrap.sh is mainly used to build docker images. Maybe remove bootstrap.sh and move code to Dockerfile template in birdhousebuilder.recipe.docker.
