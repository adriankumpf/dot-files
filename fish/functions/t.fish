function t --wraps tmux
  # If provided with args, pass them through.
  if count $argv > /dev/null
    tmux $argv
    # Create (or attach to an existing) session
  else
    tmux new -A -s (basename (pwd))
  end
end
