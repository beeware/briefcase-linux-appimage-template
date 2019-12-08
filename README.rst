Briefcase Linux AppImage Template
=================================

A template for building Python apps that will run under Linux, packaged as
an AppImage

**This repository branch contains a template for Python 3.8**.
Other Python versions are available by cloning other branches of repository.

Using this template
-------------------

The easiest way to use this project is to not use it at all - at least,
not directly. `Briefcase <https://github.com/beeware/briefcase/>`__ is a
tool that uses this template, rolling it out using data extracted from
your ``pyproject.toml``.

However, if you *do* want use this template directly...

1. Install `cookiecutter`_. This is a tool used to bootstrap complex project
   templates::

    $ pip install cookiecutter

2. Run ``cookiecutter`` on the template::

    $ cookiecutter https://github.com/beeware/briefcase-linux-appimage-template --checkout 3.8

3. `Download the Python Linux support package for x86_64`_, and extract it into
   the ``My Project.AppDir/usr`` directory

   Alternatively, you can download the `Python-Apple-support`_ project, and
   build your own versions of these frameworks.

4. Add your code to the template. At the very minimum, you need to have an
   ``<formal name>.AppDir/usr/app/<app name>/__main__.py`` file that defines an
   entry point that will start your application. If ``<app name>`` contains a
   dash, it will be converted to an underscore in the expected package name.

   If your code has any dependencies, they should be installed under the
   ``app_packages`` directory.

If you've done this correctly, a project with a formal name of ``My Project``,
with an app name of ```my-project`` should have a directory structure that
looks something like::

    My Project.AppDir/
        usr/
            app/
                my_project/
                    __init__.py
                    __main__.py
                    app.py
            app_packages/
                ...
            bin/
                python3
                ...
            share/
                ...
        com.example.my-project.desktop
        briefcase.toml

This directory can then be compiled into an AppImage using `linuxdeploy`_.
Download the `linuxdeploy AppImage`_, and make the binary executable::

    $ chmod +x linuxdeploy-x86_64.AppImage

Then compile your AppDir directory (substituting your release version number)::

    $ VERSION=1.2.3 ./linuxdeploy-x86_64.AppImage --appdir=My\ Project.AppDir -o appimage -d My\ Project.AppDir/com.example.my-project.desktop

This will produce ``My Project-1.2.3-x86_64.AppImage``. This image can given
to any other Linux user, and should run without installing any other
dependencies.

Next steps
----------

Of course, just running Python code isn't very interesting by itself - you'll
be able to output to the console, but that's it.

To do something interesting, you'll need to work with the native system
libraries to draw widgets and respond to screen taps. One option is the `toga`_
library, which is a cross-platform widget toolkit that supports Linux/GTK.

If you have any external library dependencies (like ``toga``, or anything other
third-party library), you should install the library code into the
``app_packages`` directory. This directory is the same as a  ``site_packages``
directory on a normal Python install.

.. _cookiecutter: http://github.com/audreyr/cookiecutter
.. _Download the Python Linux support package for x86_64: https://briefcase-support.s3-us-west-2.amazonaws.com/python/3.8/macOS/Python-3.8-linux-x86_64-support.b1.tar.gz
.. _toga: http://beeware.org/toga
.. _linuxdeploy: https://github.com/linuxdeploy/linuxdeploy
.. _linuxdeploy AppImage: https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
