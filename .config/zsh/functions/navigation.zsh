# Navigation functions

# Auto-ls on directory change
function chpwd() { ls }

# ghq + peco integration
function peco-ghq() {
  local selected_dir=$(ghq list | peco --prompt="GHQ>")
  if [ -n "$selected_dir" ]; then
    cd $(ghq root)/$selected_dir
  fi
}

# z + peco integration
function zz() {
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    cd $res
  fi
}