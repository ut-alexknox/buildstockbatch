Installation
------------

BuildStockBatch installations depend on the `ResStock
<https://github.com/NREL/resstock>`__ or ComStock repository. Either ``git
clone`` it or download a copy of it or your fork or branch of it with your
projects.

.. _local-install:

Local
~~~~~

This method works for running the simulations locally. BuildStockBatch simulations are
computationally intensive. Local use is only recommended for small testing runs.

OpenStudio Installation
.......................

Download and install the `OpenStudio release`_ that corresponds to your
operating system and the release of ResStock or ComStock you are using.

It's common to need a couple different versions of OpenStudio available for
different analyses. This is best achieved by downloading the ``.tar.gz`` package
for your operating system and unzipping it into a folder rather than installing
it. To let BuildStockBatch know which OpenStudio to use, pass the path as the
``OPENSTUDIO_EXE`` environment variable.

For example to get OpenStudio 3.5.1 on an Apple Silicon Mac

.. code-block:: bash

   # Make a directory for your openstudio installations to live in
   mkdir ~/openstudio
   cd ~/openstudio
   
   # Download the .tar.gz version for your operating system, x86_64 for an Intel mac
   # This can also done using a browser from the OpenStudio releases page
   curl -O -L https://github.com/NREL/OpenStudio/releases/download/v3.5.1/OpenStudio-3.5.1+22e1db7be5-Darwin-arm64.tar.gz
   
   # Extract it
   tar xvzf OpenStudio-3.5.1+22e1db7be5-Darwin-arm64.tar.gz
   
   # Optionally remove the tar file
   rm OpenStudio-3.5.1+22e1db7be5-Darwin-arm64.tar.gz

   # Set your environment variable to point to the correct version
   # This will only work for the current terminal session
   # You can also set this in ~/.zshrc to make it work for every terminal session
   export OPENSTUDIO_EXE="~/openstudio/OpenStudio-3.5.1+22e1db7be5-Darwin-arm64/bin/openstudio"

For Windows, the process is similar.

   1. Download the Windows `OpenStudio release`_ for windows with the ``.tar.gz`` extension.
      For OpenStudio 3.5.1 that is ``OpenStudio-3.5.1+22e1db7be5-Windows.tar.gz``.
   2. Extract it to a folder that you know.
   3. Set the ``OPENSTUDIO_EXE`` environment variable to the path.
      ``C:\path\to\OpenStudio-3.5.1+22e1db7be5-Windows/bin/openstudio.exe``
      Here's how to `set a Windows environment Variable`_.


.. _set a Windows environment Variable: https://www.computerhope.com/issues/ch000549.htm
.. _OpenStudio release: https://github.com/NREL/OpenStudio/releases


BuildStockBatch Python Library
..............................

Install Python 3.8 or greater for your platform. Either the official
distribution from python.org or the `Anaconda distribution
<https://www.anaconda.com/distribution/>`_ (recommended).

Get a copy of BuildStockBatch either by downloading the zip file from GitHub or
`cloning the repository <https://github.com/NREL/buildstockbatch>`_.

Optional, but highly recommended, is to create a new `python virtual
environment`_ if you're using python from python.org, or to create a new `conda
environment`_ if you're using Anaconda. Make sure you configure your virtual environment to use Python 3.8 or greater. Then activate your environment.

.. _python virtual environment: https://docs.python.org/3/library/venv.html
.. _conda environment: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html

Install the library by doing the following:

::

   cd /path/to/buildstockbatch
   python -m pip install -e . --user

.. _aws-user-config-local:

AWS User Configuration
......................

To upload BuildStockBatch data to AWS at the end of your run and send results to AWS Athena, you'll need to
configure your user account with your AWS credentials. This setup only needs to be done once.

1. `Install the AWS CLI`_ version 2
2. `Configure the AWS CLI`_. (Don't type the ``$`` in the example.)
3. You may need to `change the Athena Engine version`_ for your query workgroup to v2 or v3.

.. _Install the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
.. _Configure the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration
.. _change the Athena Engine version: https://docs.aws.amazon.com/athena/latest/ug/engine-versions-changing.html

.. _eagle_install:

Eagle
~~~~~

BuildStock Batch is preinstalled on Eagle. To use it, `ssh into Eagle`_,
activate the appropriate conda environment:

.. _ssh into Eagle: https://www.nrel.gov/hpc/eagle-user-basics.html

::

   module load conda
   source activate /shared-projects/buildstock/envs/buildstock-X.X

You can get a list of installed environments by looking in the envs directory

::

   ls /shared-projects/buildstock/envs

.. _aws-user-config-eagle:

AWS User Configuration
......................

To use the automatic upload of processed results to AWS Athena, you'll need to
configure your user account with your AWS credentials. This setup only needs to
be done once.

First, `ssh into Eagle`_, then
issue the following commands

::

   module load conda
   source activate /shared-projects/buildstock/envs/awscli
   aws configure

Follow the on screen instructions to enter your AWS credentials. When you are
done:

::

   source deactivate

Developer installation
......................

For those doing development work on BuildStock Batch (not most users), a new
conda environment that includes buildstock batch is created with the bash
script `create_eagle_env.sh` in the git repo that will need to be cloned onto
Eagle. The script is called as follows:

::

   bash create_eagle_env.sh envname

This will create a directory ``/shared-projects/buildstock/envs/env-name`` that
contains the conda environment with BuildStock Batch installed. This environment
can then be used by any user.

If you pass the ``-d`` flag to that script, it will install the buildstock-batch
package in development mode meaning that any changes you make in your cloned
repo will immediately be available to that environment. However, it means that
only the user who installed the environment can use it.

If you pass the flag ``-e /projects/someproject/envs``, it will install the
environment there instead of the default location. This is useful if you need a
specific installation for a particular project.

The ``-d`` and ``-e`` flags can also be combined if desired

::

   bash create_eagle_env.sh -d -e /projects/enduse/envs mydevenv


Amazon Web Services (Beta)
~~~~~~~~~~~~~~~~~~~~~~~~~~

The installation instructions are the same as the :ref:`local-install`
installation. You will need to use an AWS account with appropriate permissions.
The first time you run ``buildstock_aws`` it may take several minutes,
especially over a slower internet connection as it is downloading and building a docker image.
