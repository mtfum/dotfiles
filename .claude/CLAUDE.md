# CLAUDE.md

This file provides instructions and context for Claude Code when working with projects on this system.

## User Preferences

### Development Environment
- **Primary Language**: JavaScript/TypeScript, Swift (iOS development)
- **Package Manager**: Yarn (preferred over npm)
- **Version Manager**: mise (for Node.js, Python, Go, and CLI tools)
- **Shell**: Zsh with custom aliases and functions
- **Editor**: VS Code

### Coding Style
- Use modern ES6+ JavaScript features
- Prefer functional programming patterns where appropriate
- Follow existing code conventions in each project
- Use mise for managing tool versions, not individual version managers

### Git Workflow
- Commit messages should be descriptive and use gitmoji when appropriate
- Use `git` command directly (not `g` alias) for clarity
- Always create backups before major changes
- Never commit sensitive information

### System Configuration
- macOS development environment
- Homebrew for system packages
- mise for language versions and CLI tools
- Custom dotfiles configuration with modular shell setup

## Important Notes

1. **Secret Management**: Sensitive data should go in `.local` files (e.g., `.gitconfig.local`)
2. **Path Management**: mise shims are in PATH for version management
3. **Shell Functions**: Custom functions are organized in `~/.config/zsh/`
4. **Backup Strategy**: Use `~/.dotfiles/scripts/backup-dotfiles.sh` before major changes

## Project-Specific Instructions

When working on iOS projects:
- Use Tuist for project generation when available
- Clear DerivedData with `derived` alias when needed
- Use `xcode()` function to open projects

When working on web projects:
- Check for project-specific mise configuration
- Use yarn for package management
- Follow existing linting and formatting rules

## Helpful Commands

- `dev` - Navigate to ~/Developments
- `gwm` - Go Workspace Manager (via mise)
- `claude` - Claude CLI (via npx)
- `airport` - WiFi diagnostic tool
- `wifi on/off` - Toggle WiFi

## Testing and Quality

- Run linting and type checking before committing
- Use pre-commit hooks when available
- Test changes in isolated environments when possible
- Document non-obvious code decisions