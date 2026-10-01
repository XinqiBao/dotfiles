# dotfiles

Personal configuration for Bash, tmux, Vim, Neovim, C/C++ tooling, and X11. Configuration paths mirror their intended locations relative to `$HOME`. This repository has no installer.

## Contents

- `.bashrc`, `.tmux.conf`: shell and terminal multiplexer settings.
- `.vimrc`, `.config/nvim/`: separate Vim and Neovim configurations.
- `.clang-format`, `.config/clangd/`, `.ycm_extra_conf.py`: C/C++ tooling.
- `.xinitrc`, `.config/x11/`: X11 startup, resources, and key bindings.

## Use

Link or copy the relevant files into place, or merge them with existing settings. Editor plugins and external commands generally require separate installation. Review hard-coded paths, display settings, and other machine-specific assumptions before use, then test the affected tools.

## Maintenance

Prefer each tool's supported commands, APIs, and defaults where they fit the intended workflow. Treat upstream examples as patterns to evaluate against this configuration and environment, not recipes to copy unchanged. Add small local code only for a concrete need.

Before changing behavior, inspect the related and sourced files, mappings, and dependencies. Keep edits focused, verify startup and affected workflows, and describe intentional behavior changes or validation limits.
