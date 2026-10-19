{ ... }:

{
  imports = [ ./notes.nix ];

  # Enable repeat key when holding down
  targets.darwin.defaults."md.obsidian".ApplePressAndHoldEnabled = false;
}
