# Utility functions

# WiFi management
function wifi() {
  option="${1}"
  case "${option}" in
    on) networksetup -setairportpower en0 on ;;
    off) networksetup -setairportpower en0 off ;;
  esac
}

# Incremental mdfind
function incremental_mdfind() {
  mdfind -onlyin ~/Developments $@ | peco | xargs -I {} code {}
}

# Gitignore generator
function gi() { 
  curl -L -s https://www.gitignore.io/api/$@ ;
}