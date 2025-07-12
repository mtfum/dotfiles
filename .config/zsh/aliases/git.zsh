# Git aliases
alias g='git'

# Gitignore generator
function _gi() { curl -s https://www.gitignore.io/api/$1 ;}
alias gi='_gi $(_gi list | gsed "s/,/\n/g" | peco )'