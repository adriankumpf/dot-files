function update
switch (uname)
  case Darwin
    fnm list >/dev/null
    fnm latest
end

fisher u

if [ (which brew) ]
  brew update
  brew upgrade
  brew cleanup
end


# for package in (npm -g outdated --parseable --depth=0 | cut -d: -f2)
#   npm -g install "$package"
# end

yarn global upgrade

~/.config/nvim/sync.sh

echo "Don't forget to update uBlock Origin manually: https://github.com/el1t/uBlock-Safari/releases"
end
