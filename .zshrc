# vim:set fdm=marker:

# zplug
# source ~/.zplug/init.zsh
# zplug "sorin-ionescu/prezto"
# zplug load --verbose
#

export LANG=ja_JP.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"

# laravel
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# rustup
export PATH="$PATH:$HOME/.cargo/bin"

# mise - universal version manager
eval "$(mise activate zsh)"

# use key map like emacs
bindkey -e

# The next line updates PATH for the Google Cloud SDK.
source '/Users/fumiya.yamanaka/google-cloud-sdk/path.zsh.inc'

# The next line enables bash completion for gcloud.
# source '/Users/fumiya.yamanaka/google-cloud-sdk/completion.bash.inc'

# history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
# append history when exit shell
setopt append_history

# extended format for history
setopt extended_history

# beep when no history
unsetopt hist_beep

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

# Source Prezto.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

# variable expansion for prompt
setopt prompt_subst

# expansion of percent for prompt variable
setopt prompt_percent

# output CR when generating characters without trailing CR into prompt
setopt prompt_cr

# visible CR when output CR by prompt_cr
setopt prompt_sp

# PROMPT for correct
SPROMPT="zsh: Did you mean: %{[4m[31m%}%r%{[14m[0m%} [nyae]? "

# completion settings
source $HOME/.zsh/completion.zsh
# Initialize the completion system
autoload -Uz compinit
# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist


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

# beep when no result
unsetopt list_beep

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

# color settings
autoload -U colors: colors

# auto change directory
setopt auto_cd
# auto ls after cd
function chpwd() { ls }
# alias
alias ...='cd ../..'
alias ....='cd ../../..'

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


# homebrew
brew=`which brew 2>&1`
if [[ $? == 0 ]]; then
        . `brew --prefix`/etc/profile.d/z.sh
fi
function precmd ()
{
        brew=`which brew 2>&1`
        if [[ $? == 0 ]]; then
                _z --add "$(pwd -P)"
        fi
}


# gi
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

#local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# alias
alias ls='ls -a -G'
alias dev='cd ~/Developments'
alias sed='gsed'
alias g='git'

## docker
alias dl='docker ps -l -q'
alias da='docker ps -a'
alias dat='docker attach `dl`'

# get .gitignore from gitignore.io with Peco
function _gi() { curl -s https://www.gitignore.io/api/$1 ;}
alias gi='_gi $(_gi list | gsed "s/,/\n/g" | peco )'

#
alias airport=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport

#Hub
eval "$(hub alias -s)"

# fastlane
export PATH="$HOME/.fastlane/bin:$PATH"
export FASTLANE_PASSWORD="4WD,46EdkynRL639i#LzW>rC"

# bear
alias bear='~/dotfiles/scripts/bear.swift'

## processing
alias processing='processing-java'

# xcode-select
xcs() {
  xcode=$(ls /Applications/ | grep Xcode | fzf | awk '{ print $1 }')

  sudo xcode-select -s /Applications/$xcode
  return
}

## xcode
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


## peco
function ch() {
	git ch `git ba | peco --layout bottom-up --prompt "Git Branch" | sed 's|remotes/origin/||'`
}
function zz() {
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco --layout bottom-up --prompt "Dir")
  if [ -n "$res" ]; then
    BUFFER+="cd '$res'"
    zle accept-line
  else
    return 1
  fi
}
zle -N zz
bindkey '^z' zz

function incremental_mdfind() {
    cd "$(mdfind -onlyin ./ 'kMDItemContentType == "public.folder" || kMDItemFSNodeCount > 0' | sort -r | peco --layout bottom-up --prompt "Dir mdfind" --query="$*")"
    zle accept-line
}
zle -N incremental_mdfind
bindkey '^t' incremental_mdfind

function peco-ghq() {
    ghq look $(ghq list | peco)
}

function wifi() {

	networksetup -setairportpower en0 off
	networksetup -setairportpower en0 on
}

# deriveddata削除
alias derived='rm -rf ~/Library/Developer/Xcode/DerivedData/*'

# worktree移動 - cd worktrees
fcdw() {
    # カレントディレクトリがGitリポジトリ上かどうか
    git rev-parse &>/dev/null
    if [ $? -ne 0 ]; then
        echo fatal: Not a git repository.
        return
    fi

    local selectedWorkTreeDir=`git worktree list | fzf | awk '{print $1}'`

    if [ "$selectedWorkTreeDir" = "" ]; then
        # Ctrl-C.
        return
    fi

    cd ${selectedWorkTreeDir}
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fbrm - checkout git branch (including remote branches)
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fbrd - git branch -d
fbrd() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -d $(echo "$branch" | awk '{print $1}')
}

# fchb - git worktree add ./worktree/hoge hoge
fwa() {
  echo "TODO: worktreeの中にいないか、すでに存在しないか"
  # カレントディレクトリがGitリポジトリ上かどうか
  git rev-parse &>/dev/null
  if [ $? -ne 0 ]; then
      echo fatal: Not a git repository.
      return
  fi

  local branch directory
  branch=mtfum/$1
  directory=./worktree/$1

  git branch $branch &&
  git worktree add $directory $branch &&
  cd $directory
}

# intl入れるためにbrewのphpにpath通す
export PATH="/usr/local/opt/php@7.1/bin:$PATH"

# sshを表示する
export GIT_SSH=$(which ssh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/node/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# starship: https://github.com/starship/starship
eval "$(starship init zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Android: https://docs.expo.io/versions/v36.0.0/workflow/android-studio-emulator/ 
export ANDROID_SDK=/Users/fumiya.yamanaka/Library/Android/sdk
export PATH=/Users/fumiya.yamanaka/Library/Android/sdk/platform-tools:$PATH

# dart
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/fvm/default/bin"

source /Users/fumiya.yamanaka/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /Users/fumiya.yamanaka/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/fumiya.yamanaka/.zsh/history.zsh
source /Users/fumiya.yamanaka/.zsh/key-bindings.zsh
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# JAVA_HOME, maven
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:/opt/apache-maven/bin


echo "🎉  Completed to source .zshrc 🎉 "

