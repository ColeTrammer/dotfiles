###
### Autosuggestion
###

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# fzf default options
zstyle ':fzf-tab:*' fzf-flags `echo $FZF_DEFAULT_OPTS`
# tmux popup support
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

###
### Keybindings
###

# zsh autosuggestion
bindkey '^^' autosuggest-execute
bindkey '^ ' autosuggest-accept
bindkey '^E' autosuggest-clear

# history navigation
bindkey '^P' up-history
bindkey '^N' down-history

# normal editor keybindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[3;5~" kill-word
bindkey "^[[3;3~" kill-word
bindkey "^[[3~" delete-char
bindkey "^[[5~" beginning-of-buffer-or-history
bindkey "^[[6~" end-of-buffer-or-history
bindkey "^W" backward-kill-word
bindkey "^[[H" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[OF" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# shortcuts
bindkey -s '^O' '^U nvim\n'
bindkey -s '^[l' '^U clear\n'
bindkey -s '^B' '^U btm\n'

# control+d to exit
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

###
### FZF
###
fzf-tmux-pos() {
  local xmax=120
  local ymax=30

  local pos x y w h l
  pos=(
    $(tmux display-message -p "#{pane_top} #{cursor_y} #{pane_left} #{cursor_x} #{window_height} #{window_width}")
  )
  y=$((pos[1] + pos[2]))
  x=$((pos[3] + pos[4]))

  w=$((pos[6] - x))
  if ((w > xmax)); then
    w=$xmax
  fi
  if ((y < pos[5] / 2)); then
    h=$((pos[5] - y))
    if ((h > ymax)); then
      h=$ymax
    fi
    y=$((y + h))
    l=reverse
  else
    h=$((y - 1))
    if ((h > ymax)); then
      h=$ymax
    fi
    l=default
  fi

  fzf-tmux -x $x -y $y -p $w,$h -- --layout=$l "$@"
}

__fzfcmd() {
  if [ -z "$TMUX" ]; then
    echo fzf
  else
    echo fzf-tmux-pos
  fi
}