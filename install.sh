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
  ln -sf $current_path/neovim/autoload/utils.vim ~/.config/nvim/autoload/utils.vim
  ln -sf $current_path/neovim/spell/dictionary.utf-8.add ~/.config/nvim/dictionary.utf-8.add
  ln -sf $current_path/neovim/UltiSnips ~/.config/nvim/UltiSnips
  ln -sf $current_path/neovim/init.vim ~/.config/nvim/init.vim
}
#-----------------------------------------------------
# FISH installation
#-----------------------------------------------------

echo -n "[ Fish ]"

if ! command_exists fish; then
  echo "    Installing Fish"
  brew install fish
fi

if ! command_exists fisher; then
  echo "    Installing Fisherman"
  brew tap fisherman/tap
  brew install fisherman
fi

if [ ! -f ~/.config/fish/config.fish ]; then
  echo "    Creating config.fish!"
  ln -sf $current_path/fish/config.fish ~/.config/fish/config.fish
elif $REPLACE_FILES; then
  echo "    Deleting old config.fish!"
  rm ~/.config/fish/config.fish
  ln -sf $current_path/fish/config.fish ~/.config/fish/config.fish
else
  echo "    Keeping existing config.fish!"
fi

if [ ! -d ~/.config/fisherman/z/ ]; then
  echo "    Installing plugin: z"
  fisher z
fi
if [ ! -d ~/.config/fisherman/done/ ]; then
  echo "    Installing plugin: done"
  fisher done
fi
if [ ! -d ~/.config/fisherman/fnm/ ]; then
  echo "    Installing plugin: fnm"
  fisher fnm
fi
if [ ! -d ~/.config/fisherman/fzf/ ]; then
  echo "    Installing plugin: fzf"
  fisher fzf
fi

if [ ! -f ~/.config/fish/functions/fish_title.fish ]; then
  echo "    Installing theme: snazzy"
  ln -sf $current_path/functions/fish_title.fish ~/.config/fish/functions/fish_title.fish
  ln -sf $current_path/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
fi

if [ ! -f ~/.config/fish/functions/update.fish ]; then
  echo "    Installing update function"
  ln -sf $current_path/functions/update.fish ~/.config/fish/functions/update.fish
fi


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
