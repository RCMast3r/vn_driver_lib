{
  description = "vectornav c++ library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
    easy_cmake.url = "github:RCMast3r/easy_cmake";
  };
  outputs = { self, nixpkgs, utils, easy_cmake }:
    let
      vn_lib_overlay = final: prev: {
        vn_lib = final.callPackage ./default.nix { };
      };
      py_vn_lib_overlay = final: prev: {
        py_vn_lib = final.callPackage ./python.nix { };
      };
      my_overlays = [ easy_cmake.overlays.default vn_lib_overlay py_vn_lib_overlay ];
      pkgs_x86_64_linux = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlays.default ];
      };

      pkgs_aarch64_darwin = import nixpkgs {
        system = "aarch64-darwin";
        overlays = [ self.overlays.default ];
      };
    in
    {
      overlays.default = nixpkgs.lib.composeManyExtensions my_overlays;

      packages.x86_64-linux =
        rec {
          vn_lib = pkgs_x86_64_linux.vn_lib;
          py_vn_lib = pkgs_x86_64_linux.py_vn_lib;
          default = vn_lib;
        };

      packages.aarch64-darwin =
        rec {
          vn_lib = pkgs_aarch64_darwin.vn_lib;
          py_vn_lib = pkgs_aarch64_darwin.py_vn_lib;
          default = vn_lib;
        };

      devShells.x86_64-linux.default =
        pkgs_x86_64_linux.mkShell rec {
          # Update the name to something that suites your project.
          name = "nix-devshell";
          packages = with pkgs_x86_64_linux; [
            # Development Tools
            cmake
            vn_lib
          ];

          # Setting up the environment variables you need during
          # development.
          shellHook =
            let
              icon = "f121";
            in
            ''
              export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
            '';
        };

      devShells.aarch64-darwin.default =
        pkgs_aarch64_darwin.mkShell rec {
          # Update the name to something that suites your project.
          name = "nix-devshell";
          packages = with pkgs_aarch64_darwin; [
            # Development Tools
            cmake
            vn_lib
          ];

          # Setting up the environment variables you need during
          # development.
          shellHook =
            let
              icon = "f121";
            in
            ''
              export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
            '';
        };

    };
}

