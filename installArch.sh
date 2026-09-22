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
read -p "Do you want to setup a Git SSH key? (y/n): " install_gitssh

sudo pacman -Sy

# Install yay AUR
echo "Installing yay..."
sudo pacman -S base-devel
mkdir -p "${HOME}/dev/other"
cd "${HOME}/dev/other"
if [ ! -d "${HOME}/dev/other/yay-git" ]
then
    git clone https://aur.archlinux.org/yay-git.git "${HOME}/dev/other/yay-git"
fi
cd yay-git
makepkg -si

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

#Install Brave
if [[ "$install_brave" == "y" || "$install_brave" == "Y" ]]; then
	echo "Installing Brave..."
	yay -S brave-bin
	echo "Brave installed"
else
	echo "Skipping Brave install"
fi

# Install font
if [[ "$install_hermit" == "y" || "$install_hermit" == "Y" ]]; then
  echo "Installing Hermit Nerd Font..."
  cd ~
  mkdir -p Downloads
  cd Downloads
  curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip -o Hermit.zip
  sudo mkdir -p /usr/share/fonts/Hermit
  sudo unzip Hermit.zip -d /usr/share/fonts/Hermit
  echo "Hermit Nerd font installed"
else
  echo "Skipping Hermit Nerd font installation"
fi

# Setup SSH key
if [[ "$install_gitssh" == "y" || "$install_gitssh" == "Y" ]]; then
	ssh_key_path="${HOME}/.ssh/id_ed25519"

    if [ -f "${ssh_key_path}" ]
    then
        echo "SSH key already exists at ${ssh_key_path}, skipping generation."
    else
        read -p "Enter email for SSH key: " ssh_key_email
        ssh-keygen -t ed25519 -C "${ssh_key_email}" -f "${ssh_key_path}"
    fi

    eval "$(ssh-agent -s)"
    ssh-add "${ssh_key_path}"

	echo "Add the following to your GitHub SSH keys"
	cat "${ssh_key_path}.pub"
else
  echo "Skipping Git SSH key setup"
fi

# Enable pacman timer
echo "Enabaling pacman timer..."
sudo systemctl enable --now paccache.timer
