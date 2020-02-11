#!/bin/bash

# https://github.com/herrbischoff/awesome-osx-command-line

# Startup Chime: https://gist.github.com/ppo/6204781

# Install Command Line Tools without Xcode
xcode-select --install

# Set Dock Settings
defaults write com.apple.Dock autohide -float 1
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.Dock autohide-time-modifier -float 0.5
defaults write com.apple.Dock expose-animation-duration -float 0.15
defaults write com.apple.Dock largesize -float 42
defaults write com.apple.Dock magnification -float 1
defaults write com.apple.Dock minimize-to-application -float 0
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.Dock orientation -string left

# Auto Rearrange Spaces Based on Most Recent Use (Disable)
defaults write com.apple.dock mru-spaces -bool false

killall Dock

# Show All File Extensions
defaults write -g AppleShowAllExtensions -bool true

# Show Full Path in Finder Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Save to Disk by Default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Set Current Folder as Default Search Scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable Creation of Metadata Files on Network Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Creation of Metadata Files on USB Volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Hide removable media
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Automatic Restart on System Freeze
sudo systemsetup -setrestartfreeze on

# Key Repeat Rate
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Screensaver Immediate Lock
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screensaver Password Enable
defaults write com.apple.screensaver askForPassword -int 1

# Set Login Window Text
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText ""

# Enable Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Disable window-opening animation
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO
