# dotfiles

## General

macOS only.

## License

See `LICENSE` file.

## Installation

1. Clone this repo and [sync the config files](#synchronize-configuration-files) to their appropriate locations.

2. Install [Homebrew](https://brew.sh/)
   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

3. Sync Homebrew packages
   `brew bundle install`

4. Install Oh-My-Zsh
   `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

## Synchronize configuration files

[dotbot](https://github.com/anishathalye/dotbot) should take care of everything by placing symlinks in the appropriate places.

```
git submodule update --init --recursive
./install
```
