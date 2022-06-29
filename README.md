# dotfiles

## General

Intended for macOS.

## License

See `LICENSE` file.

## Installation

### macOS

1. Run `./scripts/macos_defaults.sh` to automatically set some convenient defaults.

2. To adjust key repeat settings in macOS:

   1. System Preferences -> Keyboard
   2. Key Repeat -> Fast
   3. Delay Until Repeat -> Short

3. Disable spelling autocorrect

   1. System Preferences -> Keyboard
   2. 'Text' Tab
   3. Uncheck 'Correct spelling automatically'
   4. Uncheck 'Capitalize words automatically'

### Packages

1. Clone this repo and [sync the config files](#synchronize-configuration-files) to their appropriate locations.

   - `DefaultKeyBinding.dict` will be added/replaced which will make `Home` and `End` keys behave like Windows.

2. Install [Homebrew](https://brew.sh/)

   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

3. Sync Homebrew packages

   `brew bundle install`

### [zsh](https://www.zsh.org/)

1. Install [Oh My Zsh](https://ohmyz.sh/)

   `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### [neovim](https://neovim.io/)

1. Add additional neovim language servers

   `npm i -g vscode-langservers-extracted`

2. Install [packer.nvim](https://github.com/wbthomason/packer.nvim)

   `git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim`

3. Run `:PackerSync` in neovim

### [tmux](https://github.com/tmux/tmux)

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

   `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

## Synchronize configuration files

[dotbot](https://github.com/anishathalye/dotbot) should take care of everything by placing symlinks in the appropriate places.

```
git submodule update --init --recursive
./install
```
