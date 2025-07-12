# Xcode functions

# Open Xcode project/workspace
function xcode() {
  if ls *.xcworkspace 1> /dev/null 2>&1; then
    echo 'Opening workspace...'
    open *.xcworkspace
  elif ls *.xcodeproj 1> /dev/null 2>&1; then
    echo 'Opening project...'
    open *.xcodeproj
  elif ls *.playground 1> /dev/null 2>&1; then
    echo 'Opening playground...'
    open *.playground
  else
    echo "Nothing to open"
  fi
}

# Channel selection
function ch() {
  carthage bootstrap --platform iOS --cache-builds --configuration Debug-$1
}