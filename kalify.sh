# Get a package from Kali rather than default repo
# Exit if no Ubuntu version
(apt-cache policy $1 | grep "500 http") || exit
PREFSF=/etc/apt/preferences.d/kali-prefs
grep "Package: $1\\b" $PREFSF && exit
apt-cache policy $1
echo "Adding $1 to apt prefs"
echo '' >> $PREFSF
echo 'Package: '$1 >> $PREFSF
echo 'Pin: release o=Kali' >> $PREFSF
echo 'Pin-Priority: 500' >> $PREFSF
