#!/usr/bin/env bash
echo
echo -e "Running post install script: $0"
echo 

# surf
# ! [ -d $HOME/Git ] && mkdir $HOME/Git
# git clone http://git.suckless.org/surf $HOME/Git/surf
# cd $HOME/Git/surf
# sudo make clean install || exit 1
# cd -

# sublime text
if ! dpkg -s sublime-text >& /dev/null ; then
	echo "Installing sublime text"
	# install 
	if ! [ -f /tmp/sublime-text.deb ]; then
		wget https://download.sublimetext.com/sublime-text_build-3126_amd64.deb -O /tmp/sublime-text.deb
	fi
	sudo dpkg -i /tmp/sublime-text.deb || {
		echo "Failed to install SUBLIME TEXT"
		exit 1
	}
fi 

# dropbox
if ! dpkg -s dropbox >& /dev/null ; then
	echo "Installing dropbox"
	if ! [ -f /tmp/dropbox.deb ]; then
		wget https://www.dropbox.com/download?dl=packages/debian/dropbox_2015.10.28_amd64.deb -O /tmp/dropbox.deb
	fi
	sudo dpkg -i /tmp/dropbox.deb || {
		sudo apt-get -f install -y || {
			echo "Failed to install DROPBOX"
			exit 1
		}
	}
fi

# update alternatives
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which urxvtcd) 100

sudo update-alternatives --set x-terminal-emulator $(which urxvtcd) || {
	echo "Failed to update alternatives with '$(which urxvtcd) '"
}

# upgrade pip and virtual env wrapper
sudo pip install -U pip virtualenvwrapper || {
	echo "Failed to install virtualenvwrapper and pip"
}

wget http://repo1.maven.org/maven2/org/python/jython-installer/2.7.1b3/jython-installer-2.7.1b3.jar \
						-O /tmp/jython-installer.jar && \
						java -jar /tmp/jython-installer.jar -s -d $HOME/jython || {
							echo "Failed to install jython"
						}
