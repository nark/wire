# wirebot for UNIX

## Introduction

wirebot is a command line client for the Wired 2.0 + 2.5 protocol.

This is the former CLI client "wire" (https://github.com/nark/wire) which has now been extended with bot functions by me. It is controlled via bash. See the file "cmd.sh" (which must be located in the ~/.wire folder) for details.

## Install wirebot (UNIX-like systems)

This tutorial explains how to install and run Wire-CLI-Bot on an UNIX-like operating system. (Linux, BSD, OSX, etc)

#### Howto install on:

**Debian/Ubuntu**

	sudo apt-get install -y build-essential autoconf screen git libxml2-dev libssl-dev zlib1g-dev libreadline-dev

### Getting started

Installing Wire Client from sources will be done using the Autotools standard (configure, make, make install).

##### 1. Get Wire Client sources via Terminal (git must be installed!):

	git clone https://github.com/ProfDrLuigi/wirebot

Then move to the `wire` directory:

	cd wirebot/

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

##### 6. Running Wire-CLI-Bot

It´s designed to run it in a screen-Session.

To start an installed Wire-Cli-Bot, run:

	screen -Sdm wirebot /usr/local/bin/wirebot

It´s very important to run it this way because all Bot-Functions assumes that there is a screen session "wirebot" (p0) running.

You can inject any Text from any script to the session this way:
	
	screen -S wirebot -p0 -X stuff "Hello world!"^M

To enter the running screen session simply type:
	
	screen -rS wirebot
	
To leave the session (not closing!) type

	ctrl + a and than d

If you are not familiar with "screen" visit this Site e.g.:

	https://linuxize.com/post/how-to-use-linux-screen

##### 6. Configuration

Default path for the configuration file is:

	~/.wirebot/wirebot.conf
	
Example configuration:

	open -l USER -p PASSWORT -P PORT URL
	nick YOUR_NAME
	status YOUR_STATUS
	icon YOUR_ICON.png (absolute path)
	
You can use bookmarks too. Simply name the file e.g. "my_server" and locate it in the .wire directory. Call it this way:

	/usr/local/bin/wirebot my_server


If you want to know the available commands of the client type

	/help
	
in the Chat Main window.

If you got/send a msg you can cycle through the windows with:

	ctrl+n / ctrl+p

### Get More

If you are interested in the Wired project, check the Website at [https://wired.read-write.fr/](https://wired.read-write.fr)

### Troubleshootings

This implementation of the Wired 2.0/2.5 protocol is not compliant with the version of the protocol distributed by Zanka Software, for several deep technical reasons.

CONTRIBUTORS
============

- Erik Tengblad
- christ25
