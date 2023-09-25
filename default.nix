# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage
{pkgs ? import <nixpkgs> {}}: {
  # The `lib`, `modules`, and `overlay` names are special
  #lib = import ./lib {inherit pkgs;}; # functions
  #modules = import ./modules; # NixOS modules
  #overlays = import ./overlays; # nixpkgs overlays

  rbac-police = pkgs.callPackage ./pkgs/rbac-police {};
  coredns-enum = pkgs.callPackage ./pkgs/coredns-enum {};
  penelope = pkgs.python3Packages.callPackage ./pkgs/penelope {};
  kubectl-execws = pkgs.callPackage ./pkgs/kubectl-execws {};
  blueutil = pkgs.callPackage ./pkgs/blueutil {
    inherit (pkgs.darwin.apple_sdk_11_0.frameworks) Foundation IOBluetooth;
  };
}
