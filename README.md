# nix-userstyles

Generate a Firefox `userContent.css` from any base16 color palette for 150+ websites.

![nix-userstyles](screenshot.png)

## Usage

Add the flake input:

```nix
inputs.nix-userstyles.url = "github:amadejkastelic/nix-userstyles";
```

Then build your `userContent.css`:

```nix
{ pkgs, inputs, ... }:
let
  palette = inputs.nix-userstyles.inputs.nix-colors.colorSchemes."catppuccin-mocha".palette;
  userStyles = inputs.nix-userstyles.packages.${pkgs.stdenv.hostPlatform.system}.mkUserStyles palette [
    "github"
    "google"
    "wikipedia"
    # ...
  ];
in
{
  programs.firefox.profiles.default = {
    settings = {
      # required for userContent.css to be loaded
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
    userContent = builtins.readFile userStyles;
  };
}
```

- `palette` is any [nix-colors](https://github.com/misterio77/nix-colors) base16 scheme's `.palette` attrset (`base00`–`base0F`); the Catppuccin Mocha colors in each style are substituted with it positionally.
- No Stylus/Stylish extension needed — the result is a plain `userContent.css`.

## Styles

- Any style from [catppuccin/userstyles](https://github.com/catppuccin/userstyles/tree/main/styles) (~150, e.g. `github`, `youtube`, `nixos-search`, `wiki.nixos.org`, …).
- Extra styles maintained in this repo's [`userstyles/`](userstyles): `claude`, `devdocs`, `discord`, `qwant`, `slack`, `telegram`, `whatsapp-web`.
- Quick test: `nix build .#test` builds a sample with the Dracula palette over the full tested style list.

## Credits

- [knoopx/nix-userstyles](https://github.com/knoopx/nix-userstyles) — upstream this fork is based on
- [Catppuccin userstyles](https://github.com/catppuccin/userstyles)
- [SenchoPens/base16.nix](https://github.com/SenchoPens/base16.nix)
- [tinted-theming/schemes](https://github.com/tinted-theming/schemes)
