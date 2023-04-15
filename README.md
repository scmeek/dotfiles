# dotfiles

## General

Intended for macOS and Linux.

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

### linux

1. Install and configure [zsh](https://www.zsh.org/)

2. Install [Alacritty](https://alacritty.org/)

   ```sh
   sudo add-apt-repository ppa:aslatter/ppa -y
   sudo apt install alacritty
   ```

   - Set Alacritty as the preferred terminal emulator

3. Install [Nerd Fonts](https://www.nerdfonts.com)

   - [Download](https://www.nerdfonts.com/font-downloads)
      - FiraCode Nerd Font
      - FiraMono Nerd Font
      - VictorMono Nerd Font
   - Extract compressed files and move to `~/.local/share/fonts/`
   - Update fonts cache with `fc-cache -fv`


### Packages

1. Install [Homebrew](https://brew.sh/)

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Sync Homebrew packages

   ```sh
   brew bundle install --file .brewfile_macos
   # or
   brew bundle install --file .brewfile_linux
   ```

   - Follow post-install instructions

3. Clone repo and [sync the config files](#synchronize-configuration-files) to their appropriate locations

   - macOS: `DefaultKeyBinding.dict` will be added/replaced which will make `Home` and `End` keys behave like Windows

### [Zsh](https://www.zsh.org/)

1. Install [Oh My Zsh](https://ohmyz.sh/)

   ```sh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

## Synchronize configuration files

[dotbot](https://github.com/anishathalye/dotbot) should take care of everything by placing symlinks in the appropriate places.

```sh
# If submodules haven't been initialized:
git submodule update --init --recursive

./install -c install_macos.conf.yaml
# or
./install -c install_linux.conf.yaml
```

## Add cron job to auto-sync notes git repo

```sh
SCHEDULE="5 10,14,18 * * 1-5"  # mon-fri at 10:05AM, 2:05PM, and 6:05PM
NOTES_DIR=  # path of notes git repo
# ensure ~/log directory exists
./scripts/cron_add_job.sh "${SCHEDULE}" "$(pwd)/scripts/git_sync.sh \"${NOTES_DIR}\" >> ~/log/notes_git_sync.log 2>&1"
```

