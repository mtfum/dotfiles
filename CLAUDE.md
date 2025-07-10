# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview
This is a personal dotfiles repository for macOS development environment configuration. It contains configuration files for various development tools including ZSH, Vim, Git, and Hyper terminal.

## Key Commands

### Installation and Setup
- **Install Homebrew packages**: `brew bundle`
- **Install Node.js dependencies**: `yarn install` (uses Yarn as package manager)
- **Link dotfiles**: The `install.sh` script is currently experimental/not working, but intended to create symlinks from home directory to this repository

### Development Commands
Since this is a dotfiles repository, there are no build or test commands. The repository is used for:
- Managing development environment configuration
- Installing development tools via Homebrew and npm/yarn
- Configuring shell, editor, and terminal settings

## Architecture and Structure

### Core Configuration Files
- **Shell Configuration**: `.zshrc`, `.zshenv`, `.zprofile` - Configure ZSH shell environment, paths, and aliases
- **Git Configuration**: `.gitconfig` - Contains Git aliases, user configuration, and various Git settings
- **Editor Configuration**: `.vimrc` - Vim configuration with Japanese comments
- **Terminal Configuration**: `.hyper.js` - Hyper terminal appearance and behavior settings

### Package Management
- **Brewfile**: Defines all Homebrew packages, taps, and casks for macOS development tools including:
  - iOS/macOS development tools (Xcode, SwiftLint, Carthage, CocoaPods)
  - General development tools (Git, Node.js, Python, Ruby)
  - Productivity applications (VS Code, Slack, Docker, etc.)
- **package.json**: Contains Node.js dependencies (note: unusually extensive for a dotfiles repo, may be project-specific)

### Installation Script
The `install.sh` script (currently experimental) is designed to:
1. Clone the repository to `~/.dotfiles`
2. Create symbolic links from the home directory to each dotfile
3. Skip certain files like `.git`, `.DS_Store`, `README.md`, etc.

## Important Notes
- Installation script (`install.sh`) is marked as experimental and not fully functional
- Some files contain Japanese comments (install.sh, .vimrc)
- The repository mixes dotfiles configuration with what appears to be project-specific Node.js dependencies in package.json