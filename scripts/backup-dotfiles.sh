#!/bin/bash

# Backup important configuration files before updates

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📦 Creating backup in $BACKUP_DIR"

# Files to backup
BACKUP_FILES=(
    ~/.zshrc
    ~/.gitconfig
    ~/.gitconfig.local
    ~/.config/mise/config.toml
    ~/.vimrc
    ~/.hyper.js
)

# Backup each file if it exists
for file in "${BACKUP_FILES[@]}"; do
    if [ -f "$file" ]; then
        cp -p "$file" "$BACKUP_DIR/"
        echo "✅ Backed up $(basename $file)"
    fi
done

# Create restore script
cat > "$BACKUP_DIR/restore.sh" << 'EOF'
#!/bin/bash
# Restore script for this backup

BACKUP_DIR="$(dirname "$0")"

echo "🔄 Restoring from $BACKUP_DIR"
read -p "This will overwrite current configs. Continue? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    for file in "$BACKUP_DIR"/*; do
        if [ -f "$file" ] && [ "$(basename "$file")" != "restore.sh" ]; then
            target="$HOME/.$(basename "$file")"
            if [[ "$(basename "$file")" == "config.toml" ]]; then
                target="$HOME/.config/mise/config.toml"
            fi
            cp -p "$file" "$target"
            echo "✅ Restored $(basename "$file")"
        fi
    done
fi
EOF

chmod +x "$BACKUP_DIR/restore.sh"

echo "💾 Backup complete! Restore with: $BACKUP_DIR/restore.sh"