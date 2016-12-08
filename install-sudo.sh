# Surface kernel
add-apt-repository ppa:tigerite/kernel && apt-get update && apt-get install -y linux-surface && apt-get -y dist-upgrade

# Surface wifi suspend fix
mkdir /etc/pm/config.d/
echo 'SUSPEND_MODULES="iwlwifi"' >> /etc/pm/config.d/config 

# Apps
#apt-get install -y blueman bluez
apt-get install -y curl git tmux

# Kalitools repo
apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list
echo 'Package: *' > /etc/apt/preferences.d/kali-prefs
echo 'Pin: release o=Kali' >> /etc/apt/preferences.d/kali-prefs
echo 'Pin-Priority: 400' >> /etc/apt/preferences.d/kali-prefs
apt-get update -m
# Hopefully only one user dir
KALIFY=/home/`ls /home`/scripts/kalify.sh
if [ -e "$KALIFY" ]
then
	chmod +x $KALIFY
	$KALIFY apktool
	$KALIFY dex2jar
	$KALIFY bluelog
	$KALIFY wireshark
	apt-get install -y apktool dex2jar bluelog wireshark
else
	echo "No KALIFY script"
fi

# Python
apt-get install -y python-pip python2.7-dev libsdl1.2debian libfdt1 libpixman-1-0 && pip install --upgrade pip && pip install virtualenv
apt-get install -y npm ffmpeg passwordsafe
apt-get install -y python3-dev python3-pip libxml2-dev libxslt-dev
npm install -g diff-so-fancy
# sudo -H
pip3 install thefuck

# Dev Tools
apt-get install -y arduino arduino-core

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# Grub
add-apt-repository -y ppa:danielrichter2007/grub-customizer

apt-get update && apt-get install -y google-chrome-stable grub-customizer qbittorrent vlc xclip

# Reboot
apt-get upgrade -y
apt-get clean
apt-get autoremove -y
shutdown -r now
