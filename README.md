# dotfiles

## General

Intended for macOS and Linux.

## Layout

- `nix/home`: home-manager configuration shared by every host
- `nix/darwin`: macOS configuration; `default.nix` is home-manager and
  `system.nix` is nix-darwin
- `nix/profiles/<profile>`: opt-in feature sets
  - `default.nix`: home-manager
  - `darwin.nix`: home-manager, macOS only
  - `darwin-system.nix`: nix-darwin
- `nix/hosts/<host>`: per-machine composition of the above
- `nix/packages`: packages not available in nixpkgs
- `nix/**/nvim/lua`: mirrored into `~/.config/nvim/lua`

## License

See [LICENSE](https://github.com/scmeek/dotfiles/blob/master/LICENSE).

## Additional Notes

- `~/.config/zsh/.zshrc_local` is sourced, if present, for unmanaged
  machine-local configuration
