# wirebot for UNIX

## Introduction

wirebot is a command line client for the Wired 2.0 + 2.5 protocol.

This is the former CLI client "wire" (https://github.com/nark/wire) which has now been extended with bot functions by me. It is controlled via bash. See the file "wirebot.sh" (which must be located in the ~/.wirebot folder) for details.

## Install wirebot (UNIX-like systems)

This tutorial explains how to install and run wirebot on an UNIX-like operating system.

### Howto install on:

**Ubuntu/Debian10 and higher only**

	sudo apt-get install -y curl build-essential autoconf screen inotify-tools git libxml2-dev libssl-dev zlib1g-dev libreadline-dev libcurl4-gnutls-dev

**Fedora**
	
	sudo yum -y install curl screen git libtool openssl-devel sqlite-devel libxml2-devel zlib-devel readline-devel libcurl-devel autoconf gcc make inotify-tools

**CentOS**

	sudo yum install epel-release
	sudo yum -y install curl screen git libtool openssl-devel sqlite-devel libxml2-devel zlib-devel readline-devel libcurl-devel autoconf gcc make inotify-tools

**openSUSE**

	sudo zypper install curl screen libtool libopenssl-devel sqlite3-devel libxml2-devel zlib-devel readline-devel libcurl-devel autoconf gcc make inotify-tools
	
### Getting started

Installing wirebot from sources will be done using the Autotools standard (configure, make, make install).

##### 1. Get wirebot sources via Terminal:

	git clone https://github.com/ProfDrLuigi/wirebot

Then move to the `wirebot` directory:

	cd wirebot/

Initialize and update submodules repositories:

	git submodule update --init --recursive --remote
	libwired/bootstrap

Then check that the `libwired` directory was not empty and `configure` file exists.

##### 3. Run the configuration script:

During the configuration, scripts will check that your environment fills the requirements described at the top of this document. You will be warned if any of the required component is missing on your operating system.

To start configuration, use the following command:

	./configure

wirebot is designed to be installed into `/usr/local/bin` by default. To change this, run:

	./configure --prefix=/path	

If you installed OpenSSL in a non-standard path, use the following command example as reference:

	env CPPFLAGS=-I/usr/local/opt/openssl/include LDFLAGS=-L/usr/local/opt/openssl/lib ./configure

Use `./configure --help` in order to display more options.

This will require write permissions to `/usr/local/bin`, or whatever directory you set as the prefix above. Depending of your OS setup, you may require to use `sudo`.

##### 4. Compile and install Binary
	make
	sudo make install
	mkdir ~/.wirebot
	cp wirebot.sh rss.sh config ~/.wirebot
	chmod +x ~/.wirebot/wirebot.sh

Don't forget to put your credentials into ~/.wirebot/config before you start the bot the first time.

##### 5. Running wirebot (runs in a screen session)

To start the installed wirebot, run:

	/usr/local/bin/wirebot/./wirebotctl start

You can inject any Text from any script to the session this way:
	
	screen -S wirebot -p0 -X stuff "Hello world!"^M

To enter the running screen session simply type:
	
	/usr/local/bin/./wirebotctl screen
	
To leave the session (not closing!) type:

	ctrl + a and than d

##### 6. Configuration

Default path for the configuration file is:

	~/.wirebot/config
	
Example configuration:

	charset UTF-8
	open -l USER -p PASSWORT -P PORT URL
	nick YOUR_NAME
	status YOUR_STATUS
	icon /home/YOUR_USER/.wirebot/PICTURE.png
	
If you want to know the available commands of the wirebot type

	/help
	
in the Chat Main window.

If you got/send a msg you can cycle through the windows with:

	ctrl+n / ctrl+p

#### 7. Control wirebot:

	Usage:  wirebotctl [COMMAND]

	COMMAND:
	start			Start wirebot
	stop			Stop wirebot
	restart			Restart wirebot
	screen			Join screen session (To exit session press ctrl+a and than d)
	watch/nowatch		Switch filewatching on/off
	status			Show the status
	config			Show the configuration
	
	join_on			Activate greeting if user joined server
	join_off		Deactivate greeting if user joined server
	
	leave_on		Activate greeting if user leaved server
	leave_off		Deactivate greeting if user leaved server

	wordfilter_on		Activate wordfilter
	wordfilter_off		Deactivate wordfilfter
	
	common_reply_on		Activate talkativeness
	common_reply_off	Deactivate talkativeness	
	
	rssfeed_on		Activate RSS Newsfeed
	rssfeed_off		Deactivate RSS Newsfeed

By Prof. Dr. Luigi 
Original by Rafaël Warnault <dev@read-write.fr>

If you want to extent the wirebot with functions you can edit wirebot.sh in your .wirebot Directory.

### Troubleshootings

This implementation of the Wired 2.0/2.5 protocol is not compliant with the version of the protocol distributed by Zanka Software, for several deep technical reasons.

CONTRIBUTORS
============

- Erik Tengblad
- christ25
