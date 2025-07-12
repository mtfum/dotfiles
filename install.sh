#!/bin/bash

# 参考メモ: http://qiita.com/b4b4r07/items/24872cdcbec964ce2178

DOTPATH=~/.dotfiles
GITHUB_URL="https://github.com/mtfum/dotfiles"

# Check if command exists
has() {
    command -v "$1" >/dev/null 2>&1
}

# Exit with error message
die() {
    echo "$1" >&2
    exit 1
}

# Install Git if not present
if ! has "git"; then
    echo "📦 Git not found. Installing Git..."
    
    # Check if on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Try to install Xcode Command Line Tools
        echo "Installing Xcode Command Line Tools (this includes Git)..."
        xcode-select --install 2>/dev/null
        
        # Wait for installation
        echo "⏳ Please complete the Xcode Command Line Tools installation in the popup window."
        echo "Press any key to continue after installation is complete..."
        read -n 1 -s
        
        # Check if Git is now available
        if ! has "git"; then
            die "Git installation failed. Please install Git manually and try again."
        fi
    else
        die "Please install Git manually for your operating system."
    fi
    
    echo "✅ Git installed successfully!"
fi

# Install Homebrew if not present
if ! has "brew"; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    echo "✅ Homebrew installed successfully!"
fi

# Clone dotfiles repository if not exists
if [ ! -d "$DOTPATH" ]; then
    # git が使えるなら git
    if has "git"; then
        git clone --recursive "$GITHUB_URL" "$DOTPATH"

    # 使えない場合は curl か wget を使用する
    elif has "curl" || has "wget"; then
        tarball="https://github.com/mtfum/dotfiles/archive/master.tar.gz"

        # どっちかでダウンロードして，tar に流す
        if has "curl"; then
            curl -L "$tarball"

        elif has "wget"; then
            wget -O - "$tarball"

        fi | tar xv -

        # 解凍したら，DOTPATH に置く
        mv -f dotfiles-master "$DOTPATH"

    else
        die "curl or wget required"
    fi
fi

cd "$DOTPATH"
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

# Files to ignore when creating symlinks
IGNOREFILES=('.git' '.DS_Store' '.gitignore' 'README.md' 'install.sh' 'Brewfile' 'package.json' 'yarn.lock' 'migrate-to-mise.sh' 'mise-config.toml' 'CLAUDE.md')

# Create symlinks for dotfiles
echo "🔗 Creating symlinks..."
for dotfile in .??*; do
    # Skip if in ignore list
    if [[ " ${IGNOREFILES[@]} " =~ " ${dotfile} " ]]; then
        echo "⏭️  Skipped ${dotfile}"
        continue
    fi

    # Create symlink
    ln -snfv "$DOTPATH/$dotfile" "$HOME/$dotfile"
    echo "✅ Linked ${dotfile}"
done

# Special cases
echo "🔗 Creating special symlinks..."
ln -snfv "$DOTPATH/package.json" "$HOME/package.json"

# Create mise config directory and symlink
mkdir -p "$HOME/.config/mise"
ln -snfv "$DOTPATH/mise-config.toml" "$HOME/.config/mise/config.toml"
echo "✅ Linked mise config"

# Note: Old version manager cleanup removed since .zshrc is now a symlink
# Version managers should be removed from the dotfiles/.zshrc directly

echo ""
echo "🎉 Dotfiles installation complete!"
echo ""
echo "📋 Next steps:"
echo "1. Run: brew bundle"
echo "2. Run: mise install"
echo "3. Restart your terminal"
echo ""
echo "💡 To complete mise migration, run: ./migrate-to-mise.sh"