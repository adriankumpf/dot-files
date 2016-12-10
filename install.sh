#!/bin/bash

# Dont continue on error
set -e

# Existing files won't be replaced
REPLACE_FILES=false

#-----------------------------------------------------
# Functions and variables
#-----------------------------------------------------
current_path=$(pwd)

command_exists() {
  type "$1" &>/dev/null
}

install_plug_nvim() {
  curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_nvim_folder() {
  mkdir -p ~/.config/nvim/autoload
  install_plug_nvim
  ln -sf $current_path/neovim/spell/dictionary.utf-8.add ~/.config/nvim/dictionary.utf-8.add
  ln -sf $current_path/neovim/UltiSnips ~/.config/nvim/UltiSnips
  ln -sf $current_path/neovim/init.vim ~/.config/nvim/init.vim
}

#-----------------------------------------------------
# Git (config, ignore)
#-----------------------------------------------------
echo -n "[ gitconfig ]"

if [ ! -f ~/.gitconfig ]; then
  echo "    Creating gitconfig!"
  ln -sf $current_path/git/gitconfig ~/.gitconfig
elif $REPLACE_FILES; then
  echo "    Deleting old gitconfig!"
  rm ~/.gitconfig
  ln -sf $current_path/git/gitconfig ~/.gitconfig
else
  echo "    Keeping existing gitconfig!"
fi

echo -n "[ gitignore ]"

if [ ! -f ~/.gitignore ]; then
  echo "    Creating gitignore!"
  ln -sf $current_path/git/gitignore ~/.gitignore
elif $REPLACE_FILES; then
  echo "    Deleting old gitignore!"
  rm ~/.gitignore
  ln -sf $current_path/git/gitignore ~/.gitignore
else
  echo "    Keeping existing gitignore!"
fi

#-----------------------------------------------------
# Neovim, dictionary, ultisnips
#-----------------------------------------------------
echo -n "[ Neovim ]"

if ! command_exists nvim; then
  echo "    Installing Neovim!"
  brew install neovim/neovim/neovim
fi

echo -n "[ Neovim config ]"

if [ ! -d ~/.config/nvim ]; then
  echo "    Creating nvim folder!"
  mkdir ~/.config/nvim
  install_nvim_folder
elif $REPLACE_FILES; then
  echo "    Deleting old nvim folder!"
  rm -rf ~/.config/nvim
  install_nvim_folder
else
  echo "    Keeping existing nvim folder!"
fi

#-----------------------------------------------------
# Installing Ag
#-----------------------------------------------------
echo -n "[ Ag ]"

if command_exists ag; then
  if [ ! -f ~/.agignore ]; then
    echo "   Creating agignore!"
    ln -sf $current_path/other/agignore ~/.agignore
  else
    echo "   Keeping existing agignore!"
  fi
else
  echo "   Installing Ag!"
  brew install the_silver_searcher
  echo "   Creating agignore!"
  ln -sf $current_path/other/agignore ~/.agignore
fi

#-----------------------------------------------------
# Installing linters
#-----------------------------------------------------
echo -n "[ Eslint ]"

if command_exists eslint; then
  ln -sf $current_path/linters/eslintrc ~/.eslintrc
else
  if command_exists npm; then
    npm install -g eslint
    ln -sf $current_path/linters/eslintrc ~/.eslintrc
  else
    echo "   Install node and npm, then rerun script again!"
    exit
  fi
fi
