[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# emacsモード
bindkey -e
# cdの省略
setopt auto_cd
# alias {{{
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias p='cd $HOME/Documents/Projects'


alias g='git'
alias fzf='fzf-tmux -p 80%'

alias nv='nvim'

alias copypath='pwd | tr -d "\n" | pbcopy'
alias lock='i3lock -i ~/.config/i3/wallpaper_lock.png && sleep 1'
# sail
alias sail="./vendor/bin/sail"
# }}}

# コマンド類 {{{
# Enterを押すとls
function do_enter {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  echo ""
  if type "lsd" > /dev/null 2>&1; then
    lsd -a
  else
    ls -a
  fi
  echo "\n"
  zle reset-prompt
  return 0
}
zle -N do_enter
bindkey '^m' do_enter
# cdしたらls
function chpwd(){
  if type "lsd" > /dev/null 2>&1; then
    lsd -a
  else
    ls -a
  fi
}
function lspwd() {
  if type "lsd" > /dev/null 2>&1; then
    lsd
  else
    ls
  fi
}
# }}}

# plugins {{{
# zinit読み込み
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# fzf
;zinit light junegunn/fzf-bin
# tmuximum
zinit light arks22/tmuximum
# zsh起動時にtmux（ここに書いておくことで選択中に他のプラグインを読み込める）
if [ -z $TMUX ]; then
  tmuximum
fi
# 補完(Ctrl+jで決定)
zinit ice wait'!0';zinit light zsh-users/zsh-autosuggestions
bindkey '^j' autosuggest-accept
# シンタックスハイライト
zinit ice wait'!0';zinit light zdharma-continuum/fast-syntax-highlighting
# p10k
zinit ice depth=1;zinit light romkatv/powerlevel10k
# p10kの設定ファイル読み込み
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# }}}

