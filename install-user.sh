# .dotfiles
git clone --bare https://github.com/bcaller/.dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bash_aliases
dotfiles config status.showUntrackedFiles no
dotfiles diff

# Pebble
mkdir ~/pebble-dev/
cd ~/pebble-dev/
LATESTPEBBLESDKURL=`curl https://developer.pebble.com/sdk/install/linux/ | grep -m 1 -o "https:\/\/[^\" >]*64[^\" >]*\.tar\.bz2"`
LATESTPEBBLESDKNAME=`echo $LATESTPEBBLESDKURL | grep -o "pebble-sdk.*" | head -c -9`
echo "SDK $LATESTPEBBLESDKNAME"
wget $LATESTPEBBLESDKURL && tar -jxf $LATESTPEBBLESDKNAME.tar.bz2 && rm $LATESTPEBBLESDKNAME.tar.bz2
echo 'export PATH=~/pebble-dev/$LATESTPEBBLESDKNAME/bin:$PATH' >> ~/.profile
. ~/.profile
cd ~/pebble-dev/$LATESTPEBBLESDKNAME
virtualenv --no-site-packages .env
source .env/bin/activate
pip install -r requirements.txt
deactivate

echo "eval \"\$(thefuck --alias)\"" >> ~/.bash_aliases
echo "eval \"\$(thefuck --alias)\"" >> ~/.profile

# Vim
#cp /usr/share/vim/vim??/vimrc_example.vim $HOME/.vimrc

cd

#Put title bar in top bar
git clone https://github.com/deadalnix/pixel-saver.git
cd pixel-saver
# Get the last released version
git checkout 1.9
# copy to extensions directory
mkdir ~/.local/share/gnome-shell
mkdir ~/.local/share/gnome-shell/extensions
cp -r pixel-saver@deadalnix.me -t ~/.local/share/gnome-shell/extensions
# activate
gnome-shell-extension-tool -e pixel-saver@deadalnix.me

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

xdg-mime default qBittorent.desktop x-scheme-handler/magnet
gvfs-mime --set x-scheme-handler/magnet qBittorrent.desktop

# ssh-keygen -t rsa -b 4096 -C "x@y.z"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

rm -rf ~/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git remote add git-tag https://github.com/jtyr/oh-my-zsh.git
git pull git-tag
git cherry-pick git-tag/jtyr-git_tag
git remote rm git-tag
git prune
dotfiles reset --hard

TERMPROF=`dconf list /org/gnome/terminal/legacy/profiles:/`
dconf write /org/gnome/terminal/legacy/profiles:/"$TERMPROF"custom-command tmux
