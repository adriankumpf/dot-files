function bbd
  set NAME bunchbox-dev
  tmux new-session -A -s $NAME "teamocil $NAME"
end
