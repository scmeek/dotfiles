# dotfiles

## General

Intended for macOS.

## License

See [LICENSE](https://github.com/scmeek/dotfiles/blob/master/LICENSE).

## Installation

### macOS

1. Run `./scripts/macos_defaults.sh` to automatically set some convenient defaults

2. Adjust key repeat settings in macOS

   1. System Preferences -> Keyboard
   2. Key Repeat -> Fast
   3. Delay Until Repeat -> Short

3. Disable spelling autocorrect

   1. System Preferences -> Keyboard
   2. 'Text' Tab
   3. Uncheck 'Correct spelling automatically'
   4. Uncheck 'Capitalize words automatically'

### Packages

1. Clone repo and [sync the config files](#synchronize-configuration-files) to their appropriate locations

   - `DefaultKeyBinding.dict` will be added/replaced which will make `Home` and `End` keys behave like Windows

2. Install [Homebrew](https://brew.sh/)

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Sync Homebrew packages

   ```sh
   brew bundle install
   ```

### [Zsh](https://www.zsh.org/)

1. Install [Oh My Zsh](https://ohmyz.sh/)

   ```sh
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

### [Neovim](https://neovim.io/)

1. Initialize submodules to retrieve `nvim-kickstarter` `init.lua`.

   ```sh
   git submodule update --init --recursive
   ```

2. Add additional Neovim language servers

   ```sh
   npm i -g vscode-langservers-extracted
   ```

3. Open Neovim

   - [packer.nvim](https://github.com/wbthomason/packer.nvim) should install plugins
      - If not, run `:PackerSync` to force

## Synchronize configuration files

[dotbot](https://github.com/anishathalye/dotbot) should take care of everything by placing symlinks in the appropriate places.

```sh
# If submodules haven't been initialized:
git submodule update --init --recursive

./install
```
