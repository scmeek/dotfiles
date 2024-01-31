# dotfiles

## General

Intended for macOS and Linux.

## License

See [LICENSE](https://github.com/scmeek/dotfiles/blob/master/LICENSE).

## Installation

### 0. Prepare (macOS)

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

### 1. Packages

1. Install [Homebrew](https://brew.sh/)

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Clone repo and [sync the config files](#synchronize-configuration-files) to their appropriate locations

   - macOS: `DefaultKeyBinding.dict` will be added/replaced which will make `Home` and `End` keys behave like Windows

## 2. Synchronize configuration files

[dotbot](https://github.com/anishathalye/dotbot) should take care of everything by placing symlinks in the appropriate places.

```sh
# If submodules haven't been initialized:
git submodule update --init --recursive

./install -c install_macos.conf.yaml
# or
./install -c install_linux.conf.yaml
```
