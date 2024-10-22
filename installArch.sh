# Install yay AUR
git clone https://aur.archlinux.org/yay-git.git && cd yay-git
makepkg -si

#install Brave
yay -S brave-bin

# Install other packages
sudo pacman -S vi vim ripgrep neovim unzip alacritty feh rofi lxappearance ttf-font-awesome polybar tree picom cmake man man-pages tldr btop xclip xrandr

# Install font
cd ~
mkdir downloads
cd downloads
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip -o Hermit.zip
sudo mkdir /usr/share/fonts/Hermit
sudo unzip Hermit.zip -d /usr/share/fonts/Hermit

# Setup configs
cd ~
mkdir dev
cd dev
mkdir other
cd other
git clone https://github.com/jonesy-b-dev/LinuxConfigFiles
cd LinuxConfigFiles
./lcf.sh 
