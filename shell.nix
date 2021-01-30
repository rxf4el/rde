{ pkgs ? import <nixpkgs> {}, ... }:

with pkgs;
mkShell {
  buildInputs = [ gnumake gitFull nix-deploy nixFlakes ];

  shellHook = ''
    echo 
    echo -e "To activate new configuration:"
    echo -e "> make switch"
    echo
  '';
}
