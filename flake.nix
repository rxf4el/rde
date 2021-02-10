{
  description = "rxf4el's Reproducible Desktop Environment.";

  inputs = rec {

    stable.url = "github:NixOS/nixpkgs/nixos-20.09";
#
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = { type = "github";
                     owner = "nix-community";
                     repo = "home-manager";
                     inputs.nixpkgs.follows = "/unstable"; };

    emacs.url = "github:nix-community/emacs-overlay";

  };

  outputs = inputs:
    let
      lib = inputs.unstable.lib;
      inputs-with-rde = inputs // { rde = inputs.self; };
      system = "x86_64-linux";

      overlays = {
        unstable = final: prev: {
          unstable = (import inputs.unstable {
            overlays = [ inputs.emacs.overlay ];
            inherit system;
          });
        };
      };

    in {
      templates = {
        # python.poetry = {
        #   path = ./nix/templates/python/poetry;
        #   description = "Project with poetry2nix, nix devel and nix build.";
        # };
        rde = { };
      };

      # defaultTemplate = inputs.self.templates.python.poetry;
      defaultTemplate = inputs.self.templates.rde;
      
      devShell."${system}" = import ./shell.nix {
        pkgs = inputs.unstable.legacyPackages.${system};
        #import inputs.stable { inherit system; };
      };

      nixosModules = { rde = (import ./nix/modules/default.nix); };
      nixosModule = inputs.self.nixosModules.rde;

      nixosConfigurations = {
        acer-a315 = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = [ overlays.unstable ]; }

            # inputs.self.nixosModules.acer-a315
            (import ./nix/hosts/acer-a315)

            inputs.home-manager.nixosModules.home-manager
            (import ./nix/home.nix)

            inputs.self.nixosModules.rde
            (import ./nix/config.nix)

            inputs.stable.nixosModules.notDetected
          ];
          specialArgs = { inputs = inputs-with-rde; };
        };
      };
      acer-a315 = inputs.self.nixosConfigurations.acer-a315.config.system.build.toplevel;
    };
}
