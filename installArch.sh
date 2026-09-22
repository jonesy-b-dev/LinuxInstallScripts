set -euo pipefail

echo "########################################################################"
echo "#                                                                      #"
echo "# Welcome to the Arch installer, don't leave your keyboard unattended, #"
echo "# you will be propted here and there!                                  #"
echo "# Run at own risk, I am not liable for any damage caused to the system #"
echo "#                                                                      #"
echo "########################################################################"
echo " "

echo "Please only answer y, Y, n, or N to these questions; script will not work with anything else"
echo " "
read -p "Do you want to install the Hyprland ecosystem? (y/n): " install_hyprland
read -p "Do you want to install Brave browser? (y/n): " install_brave
read -p "Do you want to install Hermit Nerd font? (y/n): " install_hermit

echo "Installing yay..."
pacman -S base-devel
git clone https://aur.archlinux.org/yay-git.git && cd yay-git
makepkg -si

#install Brave
if [[ "$install_brave" == "y" || "$install_brave" == "Y" ]]; then
  yay -S brave-bin
  echo "Brave installed"
else
  echo "Skipping Brave install"
fi

# Install other packages
echo "Installing base packages..."
sudo pacman -S vi vim curl ripgrep neovim unzip foot feh tree cmake man man-pages tldr btop gdb fd lazygit gnome-themes-extra lf fish
echo "Installation base packages compelted"

# Install Hypr ecosystem
if [[ "$install_hyprland" == "y" || "$install_hyprland" == "Y" ]]; then
    sudo pacman -S hyprland hyprsunset hyprlock hyprpicker hyprshot hyprpm hyprpaper hyprshutdown
    echo "Hyprland installed successfully."
else
    echo "Skipping Hyprland installation."
fi

# Install font
if [[ "$install_hermit" == "y" || "$install_hermit" == "Y" ]]; then
  echo "Installing Hermit Nerd Font..."
  cd ~
  mkdir downloads
  cd downloads
  curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip -o Hermit.zip
  sudo mkdir /usr/share/fonts/Hermit
  sudo unzip Hermit.zip -d /usr/share/fonts/Hermit
  echo "Hermit Nerd font installed"
else
  echo "Skipping Hermit Nerd font installation"
fi

# Enable pacman timer
echo "Enabaling pacman timer..."
sudo systemctl enable --now paccache.timer
