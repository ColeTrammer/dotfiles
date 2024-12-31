###
### Options
###
setopt interactivecomments

###
### Keybindings
###

# zsh autosuggestion
# ^^ maps to ctrl+enter
bindkey '^^' autosuggest-execute
# ^] maps to shift+enter
bindkey '^]' autosuggest-accept
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
bindkey -s '^O' '^U $EDITOR\n'
bindkey -s '^[l' '^U clear\n'
bindkey -s '^B' '^U btm\n'

# control+d to exit
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

###
### Completions
###

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
# systemctl preview
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# env preview
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
# tldr preview
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
# command preview
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
# git preview
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'
# general preview
zstyle ':fzf-tab:complete:*:*' fzf-preview 'pistol ${(Q)realpath} 2>/dev/null || echo "$word"'
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
# switch group using `[` and `]`
zstyle ':fzf-tab:*' switch-group '[' ']'
# fzf default options
zstyle ':fzf-tab:*' fzf-flags `echo $FZF_DEFAULT_OPTS`
# tmux popup support
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 80 20
zstyle ':fzf-tab:*' popup-pad 120 0

###
### Syntax highlighting
###
zle_highlight=('paste:none')

###
### FZF
###
fzf-tmux-pos() {
  unsetopt localoptions ksh_arrays

  local xmax=200
  local ymax=40

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
    echo /usr/bin/env fzf
  else
    echo fzf-tmux-pos
  fi
}

function fzf() {
  $(__fzfcmd) "$@"
}
