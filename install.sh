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