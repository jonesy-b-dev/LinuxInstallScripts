# Install yay AUR
pacman -S base-devel
git clone https://aur.archlinux.org/yay-git.git && cd yay-git
makepkg -si

#install Brave
yay -S brave-bin

# Install other packages
sudo pacman -S vi vim ripgrep neovim unzip foot feh tree cmake man man-pages tldr btop gdb fd lazygit lf fish

# Install font
cd ~
mkdir downloads
cd downloads
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip -o Hermit.zip
sudo mkdir /usr/share/fonts/Hermit
sudo unzip Hermit.zip -d /usr/share/fonts/Hermit

# Enable pacman timer
sudo systemctl enable --now paccache.timer
