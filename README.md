# Wired Client for UNIX

## Introduction

Wire is a command line client for the Wired 2.0 + 2.5 protocol.

## Install Wire (UNIX-like systems)

This tutorial explains how to install and run Wire Client on an UNIX-like operating system. (Linux, BSD, OSX, etc)

#### Howto install on:

**Debian/Ubuntu**

	sudo apt-get install -y build-essential autoconf screen git libxml2-dev libssl-dev zlib1g-dev libreadline-dev

### Getting started

Installing Wire Client from sources will be done using the Autotools standard (configure, make, make install).

##### 1. Get Wire Client sources via Terminal (git must be installed!):

	git clone https://github.com/ProfDrLuigi/wire wire

Then move to the `wire` directory:

	cd wire/

Initialize and update submodules repositories:

	git submodule update --init --recursive --remote
	libwired/bootstrap

Do a fix:

	sed -i 's/mktemp/mkstemp/g' libwired/libwired/file/wi-fs.c


Then check that the `libwired` directory was not empty and `configure` file exists.

##### 3. Run the configuration script:

During the configuration, scripts will check that your environment fills the requirements described at the top of this document. You will be warned if any of the required component is missing on your operating system.

To start configuration, use the following command:

	./configure

Wire Client is designed to be installed into `/usr/local` by default. To change this, run:

	./configure --prefix=/path	

If you installed OpenSSL in a non-standard path, use the following command example as reference:

	env CPPFLAGS=-I/usr/local/opt/openssl/include \
	     LDFLAGS=-L/usr/local/opt/openssl/lib ./configure

Use `./configure --help` in order to display more options.



##### 4. Compile source code:

On GNU-like unices, type:

	make

Or, on BSD-like unices, type: 

	gmake

##### 5. Install on your system:

On GNU-like unices, type:

	make install

Or, on BSD-like unices, type: 

	gmake install

This will require write permissions to `/usr/local/bin`, or whatever directory you set as the prefix above. Depending of your OS setup, you may require to use `sudo`.

##### 6. Running Wire client

It´s advised to run it in a screen-Session.

To start an installed Wire Client, run:

	screen -dm wire /usr/local/bin/wire

To enter the running screen session simply type:
	
	screen -r
	
To leave the session (not closing!) type

	ctrl + a and than d

If you are not familiar with "screen" visit this Site e.g.:

	https://linuxize.com/post/how-to-use-linux-screen

##### 6. Configuration

Default path for the configuration file is:

	~/.wire/wire.conf
	
Example configuration:

	open -l USER -p PASSWORT -P PORT URL
	nick YOUR_NAME
	status YOUR_STATUS_
	icon YOUR_ICON.png
	
You can use bookmarks too. Simply name the file e.g. "my_server" and locate it in the .wire directory. Call it this way:

	/usr/local/bin/wire my_server

### Get More

If you are interested in the Wired project, check the Website at [https://wired.read-write.fr/](https://wired.read-write.fr)

### Troubleshootings

This implementation of the Wired 2.0/2.5 protocol is not compliant with the version of the protocol distributed by Zanka Software, for several deep technical reasons.

CONTRIBUTORS
============

- Erik Tengblad
- christ25
