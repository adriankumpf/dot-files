function update
  fnm latest

  if [ (which brew) ]
    brew update; and brew upgrade
  end


  for package in (npm -g outdated --parseable --depth=0 | cut -d: -f2)
    npm -g install "$package"
  end

  ~/.config/nvim/sync.sh
end
