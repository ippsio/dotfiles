# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS, containing configuration files for shell, terminal emulators, text editors, and various CLI tools. The repository uses a modular structure where configurations are split into multiple files and sourced from main entry points.

## Architecture

### Zsh Configuration Structure

The zsh configuration follows a numbered loading order pattern defined in `.zshrc`:

1. **00_*** files: Core setup (exports, history, options, provisioning)
2. **10_*** files: Preparation and initialization
3. **20_*** files: Aliases
4. **30_*** files: Prompt and hooks
5. **40_*** files: Keybindings and ZLE functions
6. **50_*** files: Command hacks
7. **60_*** files: Plugin loading
8. **70_*** files: Environment evaluation (e.g., direnv)
9. **80_*** files: User-defined functions

The main `.zshrc` sources files from `$HOME/dotfiles/zshrc/` in this order. Export configurations are further modularized in `zshrc/00_export/rc/` for specific tools (Homebrew, Deno, Java, FZF, etc.).

### Tmux Configuration Structure

The `.tmux.conf` file sources multiple configuration files from `.config/tmux/`:
- `tmux-bind.conf` - Keybindings
- `tmux-pane.conf` - Pane configuration
- `tmux-plugin-*.conf` - Plugin configurations (CPU, urlview, jump)
- `tmux-status-*.conf` - Status line configuration (left, right, window-status, misc)

### Neovim Configuration Structure

Located in `.config/nvim/`, the Neovim configuration uses Vim script as the primary language with Lua for modern plugin configurations:
- `init.vim` - Main entry point that sources other vim files
- `jetpack.vim` - Plugin manager configuration
- `rc/lua/*.lua` - Lua-based plugin configurations (LSP, Treesitter, Telescope, etc.)
- `rc/vim/*.vim` - Traditional Vim script configurations

### Tig Configuration

The `.tigrc` sources modular configuration files from `.config/tig/`:
- `color-light.tigrc` - Color scheme (light theme)
- `set.tigrc` - Settings
- `bind.tigrc` - Keybindings

### Binary Scripts

The `bin/` directory contains custom shell scripts organized by category:
- `git/` - Git-related utilities (log fzf, diff fzf, PR tools, review tools)
- `tmux/` - Tmux helper scripts (pane management, status bar components)
- `fzf/` - FZF integration scripts
- `tig/` - Tig helper scripts
- `misc/` - Miscellaneous utilities (color conversion, date tools, decorators)
- `docker/` - Docker utilities
- `translate/` - Translation tools
- `youtube/` - YouTube utilities
- `z_ohaka/` - Archived/deprecated scripts

## Development Commands

### Testing Changes

**Zsh**: After modifying zsh configuration files:
```bash
source ~/.zshrc
```

**Tmux**: After modifying tmux configuration:
```bash
tmux source-file ~/.tmux.conf
```

**Neovim**: Restart Neovim or use `:source $MYVIMRC`

### Linting

Secretlint is configured to detect secrets in files:
```bash
yarn run secretlint
```

## Key Patterns and Conventions

### Zsh Function Helpers (`zshrc/40_funcs.zsh`)

The repository defines custom ZLE helper functions for buffer manipulation:
- `buf1_match()` - Pattern matching on BUFFER
- `lbuf_subtract()` - Replace LBUFFER if pattern matches
- `lbuf_subtract_back()` - Same as above but moves cursor back
- `lbuf_subtract_accept()` - Same as above but accepts the line
- `lbuf_subtract_rbuf_eval()` - Evaluate command and append to RBUFFER

These are used extensively in ZLE widget definitions for custom keybindings.

### Configuration File Patterns

- **Split configurations**: Main config files (`.tmux.conf`, `.tigrc`, `.zshrc`) act as orchestrators that source modular files
- **Numbered prefixes**: Files with numeric prefixes (00_, 10_, etc.) define loading order
- **Subdirectory organization**: Related configs grouped in subdirectories (e.g., `zshrc/00_export/rc/`)

### Git Configuration

The `.gitconfig` includes:
- Custom diff colors optimized for readability
- nvim as difftool with read-only mode
- diff-highlight integration in pager
- Detailed color configuration comments explaining each setting

## File Locations

When adding new configurations:
- **Zsh aliases**: Add to `zshrc/20_alias.zsh`
- **Zsh functions**: Add to `zshrc/80_functions.zsh`
- **Zsh exports**: Add to appropriate file in `zshrc/00_export/rc/`
- **Custom scripts**: Add to appropriate subdirectory in `bin/`
- **Tmux settings**: Add to appropriate file in `.config/tmux/`
- **Neovim plugins**: Add Lua config in `.config/nvim/rc/lua/` and register in `jetpack.vim`

## Terminal Configuration

The repository includes configurations for multiple terminal emulators:
- **Kitty**: `.config/kitty/` (includes kitty-themes submodule)
- **Alacritty**: `.config/alacritty/`
- **Rio**: `.config/rio/`

## Editor Preference

The default editor is set to `nvim` (see `zshrc/00_export.zsh` and `.gitconfig`).
