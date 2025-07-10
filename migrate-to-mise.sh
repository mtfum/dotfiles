#!/bin/bash

echo "🚀 Starting migration to mise..."

# Install mise if not already installed
if ! command -v mise &> /dev/null; then
    echo "📦 Installing mise..."
    brew install mise
fi

# Get current versions from existing version managers
echo "🔍 Detecting current versions..."

# Python version from pyenv
if command -v pyenv &> /dev/null; then
    PYTHON_VERSION=$(pyenv version-name 2>/dev/null | grep -v system | head -1)
    echo "Found Python: ${PYTHON_VERSION:-not set}"
fi

# Ruby version from rbenv
if command -v rbenv &> /dev/null; then
    RUBY_VERSION=$(rbenv version-name 2>/dev/null | grep -v system | head -1)
    echo "Found Ruby: ${RUBY_VERSION:-not set}"
fi

# Node version from nvm or nodebrew
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version | sed 's/v//')
    echo "Found Node: ${NODE_VERSION:-not set}"
fi

# Go version from goenv
if command -v goenv &> /dev/null; then
    GO_VERSION=$(goenv version-name 2>/dev/null | grep -v system | head -1)
    echo "Found Go: ${GO_VERSION:-not set}"
fi

# Create project-specific .tool-versions if versions were found
if [[ -n "$PYTHON_VERSION" || -n "$RUBY_VERSION" || -n "$NODE_VERSION" || -n "$GO_VERSION" ]]; then
    echo "📝 Creating .tool-versions file..."
    rm -f .tool-versions
    
    [[ -n "$NODE_VERSION" ]] && echo "node $NODE_VERSION" >> .tool-versions
    [[ -n "$PYTHON_VERSION" ]] && echo "python $PYTHON_VERSION" >> .tool-versions
    [[ -n "$RUBY_VERSION" ]] && echo "ruby $RUBY_VERSION" >> .tool-versions
    [[ -n "$GO_VERSION" ]] && echo "go $GO_VERSION" >> .tool-versions
    
    echo "Created .tool-versions with detected versions"
fi

# Install the tools with mise
echo "📥 Installing tools with mise..."
mise install

# Trust the configuration
mise trust

echo "✅ Migration complete!"
echo ""
echo "📋 Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Verify installations with: mise list"
echo "3. You can now uninstall old version managers:"
echo "   - brew uninstall pyenv pyenv-virtualenv"
echo "   - brew uninstall rbenv ruby-build"
echo "   - brew uninstall goenv"
echo "   - brew uninstall nodebrew"
echo "   - rm -rf ~/.nvm"
echo ""
echo "💡 Tips:"
echo "- Use 'mise use node@20' to set Node version for a project"
echo "- Use 'mise install python@3.11' to install specific versions"
echo "- Check 'mise help' for more commands"