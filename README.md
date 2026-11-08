# dotfiles

Personal configuration for shells, terminals, editors, C/C++ tooling, and X11. Configuration paths mirror their intended locations relative to `$HOME`. This repository has no installer.

## Contents

- `.bashrc`, `.tmux.conf`: shell and terminal multiplexer settings.
- `.config/ghostty/config.ghostty`: Ghostty theme and macOS Option key settings.
- `.config/herdr/config.toml`: Herdr settings.
- `.config/mise/config.toml`: optional versions for selected interactive tools.
- `.vimrc`, `.config/nvim/`: separate Vim and Neovim configurations.
- `.clang-format`, `.config/clangd/`, `.ycm_extra_conf.py`: C/C++ tooling.
- `.xinitrc`, `.config/x11/`: X11 startup, resources, and key bindings.

## Use

Link or copy the relevant files into place, or merge them with existing settings. Editor plugins and external commands generally require separate installation. Review hard-coded paths, display settings, and other machine-specific assumptions before use, then test the affected tools.

To install the tools listed in `.config/mise/config.toml`, [install mise](https://mise.jdx.dev/getting-started.html), link or copy the file to `$HOME/.config/mise/config.toml`, then run `mise install` from `$HOME`. Use `mise upgrade` to update them.

Neovim installs its parser baseline asynchronously; reopen the buffer after installation. Use `:TSInstall <language>` for additional parsers and `:TSUpdate` after plugin updates. Installation requires tree-sitter CLI, a C compiler, curl, and tar.

## Herdr plugins

- [vim-herdr-navigation](https://github.com/paulbkim-dev/vim-herdr-navigation)
