function update
  if type -q nvm
    echo \nUpdating node with nvm\n
    nvm use latest
    node -v > /dev/null
  end

  if type -q fisher
    echo \nFish plugins with fisher\n
    fisher
  end

  if type -q brew
    echo \nUpdating brew packages\n
    brew update
    brew upgrade --display-times
    brew cask upgrade
    brew cleanup
  end

  # for package in (npm -g outdated --parseable --depth=0 | cut -d: -f2)
  #   npm -g install "$package"
  # end

  if type -q yarn
    echo \nUpdating global yarn packages\n
    yarn global upgrade
  end

  if type -q nvim
    nvim  +PlugUpgrade +PlugClean! +PlugUpdate +qa
    nvim +UpdateRemotePlugins +qa
  end

  if type -q rustup
    echo \nUpdating rust channels\n
    rustup update
  end

  if type -q cargo-install-update
    cargo install-update -a
  end

end
