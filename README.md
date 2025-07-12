# dotfiles

My dotfiles for macOS development environment.

## Prerequisites

- macOS (the install script will handle everything else)

## Installation

### Option 1: One-line Install (recommended)

If you already have Git:
```bash
git clone https://github.com/mtfum/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install.sh
```

### Option 2: Bootstrap Install (no prerequisites)

Start from scratch - the install script will automatically install Git and Homebrew if needed:

```bash
# Download and run install script
curl -L https://github.com/mtfum/dotfiles/archive/master.tar.gz | tar xz
mv dotfiles-master ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Option 3: Install without Git

```bash
# Download and extract dotfiles
curl -L https://github.com/mtfum/dotfiles/archive/master.tar.gz | tar xz
mv dotfiles-master ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Option 3: Step by Step

1. Clone the repository:
```bash
git clone https://github.com/mtfum/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the install script to create symlinks:
```bash
./install.sh
```

3. Install Homebrew packages:
```bash
brew bundle
```

4. Install development tools via mise:
```bash
mise install
```

5. Restart your terminal or reload configuration:
```bash
exec zsh
```

## What's Included

### Package Managers
- **Homebrew**: macOS package manager
- **mise**: Universal version manager for Node.js, Python, Go, etc.

### Shell Configuration
- **ZSH**: With fast-syntax-highlighting, autosuggestions
- **Starship**: Cross-shell prompt
- **Aliases**: Docker, Git, and custom shortcuts

### Development Tools
- **Languages**: Node.js 24, Python 3.12, Go 1.22, Ruby 3.3.6
- **iOS/macOS**: Xcode tools, SwiftLint, Carthage, CocoaPods
- **Android**: Android SDK, Flutter
- **Cloud**: Google Cloud SDK, Firebase CLI, Vercel CLI
- **Others**: Docker, Git, VS Code, and more

### Global CLI Tools (via mise)
- claude (Anthropic Claude CLI)
- firebase-tools
- vercel
- @vue/cli
- next
- wrangler
- gitmoji-cli
- ts-node
- nodemon
- tuist

## Post-Installation

Some tools may require additional setup:

1. **Conda**: Already initialized in `.zshrc`
2. **NVM**: Config included but mise is preferred
3. **Google Cloud SDK**: Run `gcloud init`
4. **Android SDK**: Set up in Android Studio

## Updating

To update everything:

```bash
cd ~/.dotfiles
git pull
brew update && brew upgrade
mise upgrade
```

## Advanced Features

### Secret Management
Sensitive information like email is stored in `~/.gitconfig.local` (not tracked by git). Copy `.gitconfig.local.example` and update with your information.

### Modular Shell Configuration
Shell configurations are organized in:
- `~/.config/zsh/aliases/` - Command aliases
- `~/.config/zsh/functions/` - Shell functions
- `~/.config/zsh/completions/` - Tab completions

### Backup & Restore
Create a backup before major changes:
```bash
~/.dotfiles/scripts/backup-dotfiles.sh
```

### Git Hooks
This repository includes pre-commit hooks that check for:
- Sensitive information in configs
- Shell script syntax errors

### Testing
The repository includes GitHub Actions for automated testing of installation scripts and configurations.

### Claude Code Configuration
This repository includes configuration for Claude Code:
- `~/.claude/CLAUDE.md` - User preferences and project instructions
- `~/.claude/settings.json` - Tool settings and hooks configuration

These files are automatically symlinked during installation.