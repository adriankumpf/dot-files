function update
  if type -q fnm
    echo \nUpdating node with fnm\n
    fnm list >/dev/null
    fnm latest
    node -v > /dev/null
  end

  if type -q fisher
    echo \nFish plugins with fisher\n
    fisher u
  end

  if type -q brew
    echo \nUpdating brew packages\n
    brew update
    brew upgrade
    brew cleanup
  end

  # for package in (npm -g outdated --parseable --depth=0 | cut -d: -f2)
  #   npm -g install "$package"
  # end

  if type -q yarn
    echo \nUpdating global yarn packages\n
    yarn global upgrade
  end

  ~/.config/nvim/sync.sh

  if type -q rustup
    echo \nUpdating rust channels\n
    rustup update
  end
end
