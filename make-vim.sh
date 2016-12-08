mkdir ~/buildgits
cd ~/buildgits
git clone https://github.com/vim/vim.git
sudo apt-get install -y libncurses5-dev libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev checkinstall
cd vim
git checkout v8.0.0095
make clean
./configure --with-features=huge \
            --enable-multibyte \
            --enable-pythoninterp=yes \
            --enable-python3interp=yes \
            --enable-cscope \
	    --enable-gui=auto \
	    --with-x

make
sudo checkinstall --deldoc=yes --deldesc=yes --gzman=yes
cd ../
# remove with
# dpkg -r vim

git clone https://github.com/powerline/fonts.git
cd ./fonts
./install.sh
cd ../
rm -rf ./fonts
TERMPROF=`dconf list /org/gnome/terminal/legacy/profiles:/`
dconf write /org/gnome/terminal/legacy/profiles:/"$TERMPROF"font 'Ubuntu Mono derivative Powerline 12'
dconf write /org/gnome/terminal/legacy/profiles:/"$TERMPROF"use-system-font false
sudo pip install --user powerline-status

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
