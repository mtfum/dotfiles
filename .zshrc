export XDG_CONFIG_HOME="$HOME/.config"
export TERM=xterm-256color
export PATH=$PATH:/usr/local/etc/bin

# .zshrc.local を読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# http://qiita.com/maxmellon/items/23325c22581e9187639e
function peco-z-search
{
	which peco z > /dev/null
	if [ $? -ne 0 ]; then
		echo "Please install peco and z"
		return 1
	fi
	local res=$(z | sort -rn | cut -c 12- | peco)
	if [ -n "$res" ]; then
		BUFFER+="cd $res"
		zle accept-line
	else
	 return 1
	fi
}
zle -N peco-z-search
bindkey '^f' peco-z-search
																								

# swiftenv
if which swiftenv > /dev/null
then
    eval "$(swiftenv init -)"
fi

# no beep sounds
setopt nolistbeep

# append history when exit shell
setopt append_history

# extended format for history
setopt extended_history

# delete duplicated history when register command
setopt hist_ignore_all_dups

# don't register history if the command with leading spaces
setopt hist_ignore_space

# remove extra spaces from command
setopt hist_reduce_blanks

# don't run command when matching
setopt hist_verify

# share history with all zsh process
setopt share_history

# make key map for history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# prompt settings
# variable expansion for prompt
setopt prompt_subst

# expansion of percent for prompt variable
setopt prompt_percent

# output CR when generating characters without trailing CR into prompt
setopt prompt_cr

# visible CR when output CR by prompt_cr
setopt prompt_sp

# load $HOME/.zsh/*
if [ -d $HOME/.zsh ]; then
  for i in `ls -1 $HOME/.zsh`; do
    echo "📦  Load $i"
    src=$HOME/.zsh/$i; [ -f $src ] && . $src
  done
fi

# completion settings
autoload -Uz compinit
compinit -u

# predictive conversion
autoload predict-on
predict-on

# don't create new prompt
setopt always_last_prompt

# do like putting * on cursor when complement
setopt complete_in_word

# output list automatically
setopt auto_list

# completion when pushed key for complement twice
unsetopt bash_auto_list

# move a command of candidates
setopt auto_menu

# set a command immediately
unsetopt menu_complete

# don't substring alias when complement
setopt complete_aliases

# reduce line of list
setopt list_packed

# show trailing character of file
setopt list_types

# set candidate immediately
# zstyle ':completion:*' menu true

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=3
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# auto change directry, adbridgement "cd"
setopt auto_cd
# auto ls after cd
function chpwd() { ls }
# alias
alias ...='cd ../..'
alias ....='cd ../../..'

# color settings
autoload -U colors: colors

# correct command
setopt correct

setopt auto_pushd
setopt cdable_vars
setopt pushd_ignore_dups
setopt auto_param_slash
setopt mark_dirs
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst
setopt print_eight_bit
setopt extended_glob
setopt globdots

# powerline-shell
function _update_ps1() {
    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

function powerline_precmd() {
	PS1="$(powerline-shell --shell zsh $?)"
}


function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# xcode
function xcode() {
  xcworkspace=$(ls | grep --color=never .xcworkspace | head -1)
  xcodeproj=$(ls | grep --color=never .xcodeproj | head -1)
  xcode=${$(xcode-select -p)%/*/*}
  if [[ -n ${xcworkspace} ]]; then
    echo "Open ${xcworkspace}"
    open -a ${xcode} ${xcworkspace}
  elif [[ -n ${xcodeproj} ]]; then
    echo "Open ${xcodeproj}"
    open -a ${xcode} ${xcodeproj}
  else
    echo "Not found Xcode files"
  fi
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh.d/z.sh
