#!/bin/sh
#
# Created by: Westley K
# email: westley@sylabs.io
# Date: Jul 31, 2018
# version-1.1.0
# https://github.com/WestleyK/backlight
#
# MIT License
#
# Copyright (c) 2018 WestleyK
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#


SCRIPT_VERSION="version-1.1.0"
SCRIPT_DATE="Aug 15, 2018"

# the name of the script to install,
SCRIPT_NAME="pi-light-sh"

# the place where the script will be installed
PATH_INSTALL="/usr/local/bin/"

OPTION=$1

help_menu() {
	echo "Usage: ./make.sh [OPTION]"
	echo "      help (print help menu)"
	echo "      install (install: $SCRIPT_NAME to: $PATH_INSTALL)"
	echo "      update (update command and repo)"
	echo "      uninstall (uninstall: $SCRIPT_NAME from: $PATH_INSTALL)"
	echo "      version (print version of install script)"
	echo "Sorce code: https://github.com/WestleyK/backlight"
	exit 0
}

script_version() {
	echo "$SCRIPT_VERSION"
	echo "$SCRIPT_DATE"
	exit 0
}

is_sudo() {
	IS_ROOT=$( id -u )
	if [ $IS_ROOT != 0 ]; then
		echo "Please run as root!"
		echo "try: sudo ./install.sh"
		exit
	fi
}

install_script() {
	is_sudo
	if [ ! -e $SCRIPT_NAME ]; then
		echo "$SCRIPT_NAME is not in this directory :O"
		exit 1
	fi
	if [ -e $PATH_INSTALL$SCRIPT_NAME ]; then
		printf "\033[0;33mWARNING: \033[0m\n"
		echo "$SCRIPT_NAME is already installed to: $PATH_INSTALL"
		echo "Continuing will overide the existing script"
		echo "Do you want to continue?"
		echo -n "[y,n]:"
		read INPUT
		if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ]; then
			echo "Overriding existing file..."
		else
			echo "Aborting!"
			echo "Install failed."
			exit 1
		fi
	fi
	echo "Installing: $SCRIPT_NAME"
	chmod +x $SCRIPT_NAME
	cp $SCRIPT_NAME $PATH_INSTALL
	echo "$SCRIPT_NAME installed to: $PATH_INSTALL"
	echo "Done."
	exit 0
}

update_script() {
	is_sudo
	echo "Updating..."
	git pull origin master
	install_script
}

uninstall_script() {
	if [ ! -e $INSTALL_PATH$SCRIPT_NAME ]; then
		echo "$SCRIPT_NAME is not installed :O"
		exit 1
	fi
	echo "Uninstalling" $SCRIPT_NAME "from" $PATH_INSTALL
	rm $PATH_INSTALL$SCRIPT_NAME
	echo "Done."
	exit 0
}

# is there a argument, than what is it?
if [ ! -z $OPTION ]; then
	if [ "$OPTION" = "help" ]; then
		help_menu
	elif [ "$OPTION" = "install" ]; then
		install_script
	elif [ "$OPTION" = "update" ]; then
		update_script
	elif [ "$OPTION" = "uninstall" ]; then
		uninstall_script
	elif [ "$OPTION" = "version" ]; then
		script_version
	else
		echo "Option not found: $OPTION"
		echo "Try: ./make.sh help"
	fi
else
	help_menu
fi



#
# End install script
#


