Experimental Java binding for libmagic
======================================

Sources for the binding were tested by compiling them on Ubuntu 12.10 against
headers from the `libmagic-dev` package version 5.11-2.

Compiled bindings proved to run without error using Oracle JDK 1.7.0\_51.


Compiling
---------

Provided `Makefile` is for compiling native code that provides JNI interface
for [libmagic][] and `build.xml` for building Java project using Apache Ant.

These are the steps necessary for successful build:

- Download [Apache commons-io][] from its [download page
  ][Apache commons-io download], unpack it and put `.jar` files in to the `lib`
  directory. It will work out-of-the-box only with version 2.4, for other
  versions please modify `nbproject/project.properties` appropriately.

- On Debian/Ubuntu install `libmagic-dev` package:

    $ sudo apt-get install libmagic-dev

- Make sure your `JAVA_HOME` environment variable is exported with correct path
  to your Java installation, e.g. like this:

    $ # Ubuntu 12.10 with oracle-java7-installer package installed
    $ export JAVA_HOME=/usr/lib/jvm/java-7-oracle

  Other option is to pass `JAVA_HOME` directly to make.

- Run `make`:

    $ make

  Example for directly passed `JAVA_HOME`:

    $ make JAVA_HOME=/usr/lib/jvm/java-7-oracle

- Run Ant:

    $ ant


[Apache commons-io]:
  https://commons.apache.org/proper/commons-io/
  "Apache commons-io homepage"
[Apache commons-io download]:
  http://commons.apache.org/io/download_io.cgi
  "Download page for Apache commons-io"
[libmagic]:
  http://swoolley.org/man.cgi/3/libmagic
  "Manual page for libmagic that describes its API"
