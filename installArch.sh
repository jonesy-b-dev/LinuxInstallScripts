# Install yay AUR
sudo pacman -S git
git clone https://aur.archlinux.org/yay-git.git && cd yay-git
makepkg -si

#install Brave
yay -S brave-bin

# Install other packages
sudo pacman -S vi vim ripgrep neovim unzip alacritty feh rofi lxappearance ttf-font-awesome polybar tree picom cmake man man-pages tldr btop

# Install font
cd ~
mkdir downloads
cd downloads
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip Hermit.zip
mkdir /usr/share/fonts/Hermit
unzip Hermit.zip -d /usr/share/fonts/Hermit

# Setup configs
cd ~
mkdir dev
cd dev
mkdir other
cd other
git clone https://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@github.com/jonesy-b-dev/LinuxConfigFiles
cd LinuxConfigFiles
cp -pr configs/.
