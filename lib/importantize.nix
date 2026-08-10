{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "importantize";
  runtimeInputs = with pkgs; [
    nodejs
    postcss
  ];
  text = ''
    export NODE_PATH="${pkgs.postcss}/lib/node_modules"
    node ${./importantize.js} "$@"
  '';
}
