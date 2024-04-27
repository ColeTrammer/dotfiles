# Cole's dotfiles and NixOS configuration

## Setup

### NixOS

Full system setup is done using [NixOS](https://nixos.wiki). You can use the graphical NixOS installer, but this won't
allow using the impermenance setup. You can partition the hard drive using the btrfs disko module,
and then install NixOS. Afterwards, you can add a configuration to `hosts/` and activate it with:

```sh
sudo nisos-rebuild switch --flake .#$HOSTNAME
```

### Home Manager

On other systems, you can still install the dotfiles using [Nix Home Manager](https://github.com/nix-community/home-manager). Follow the link for installation instructions.

After home manager is installed, you would add a new configuration to `home/configuration/$SYSTEM/$USER-$HOSTNAME.nix`.
You can activate this configuration by running a command like:

```sh
home-manager switch --flake .
```
