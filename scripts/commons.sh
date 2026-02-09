#! /bin/bash

echo "select distribution"
echo "1. debian based"
echo "2. rhel"
read -p "input " distr
case $distr in
1)
sudo apt update && sudo apt install curl wget git zip unzip p7zip-full tmux htop neovim ;;
2)
sudo dnf update && sudo dnf install curl wget git zip unzip rar unrar tmux htop neovim ;;
esac