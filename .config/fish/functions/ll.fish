function ll --wraps=eza --description 'alias ll=eza ...'
    eza -lha --group-directories-first --no-user -o --time-style=long-iso $argv
end
