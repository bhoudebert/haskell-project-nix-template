let
  packages = import ./default.nix;
  aliases = import nix/aliases.nix;
  inherit (packages) pkgs project;
  inherit (pkgs) nixpkgs-fmt shellcheck ormolu niv;

  # Do not move this for now
  nix-pre-commit-hooks = import (builtins.fetchTarball "https://github.com/cachix/pre-commit-hooks.nix/tarball/master");
  pre-commit-check = nix-pre-commit-hooks.run {
    src = ./.;
    # If your hooks are intrusive, avoid running on each commit with a default_states like this:
    # default_stages = ["manual" "push"];
    tools = {
      nixpkgs-fmt = nixpkgs-fmt;
      shellcheck = shellcheck;
    };
    hooks = {
      ormolu.enable = true;
      nixpkgs-fmt.enable = true;
      shellcheck.enable = true;
    };
  };

in
project.shellFor {

  # this could be very long ...
  # withHoogle = true;
  withHoogle = false;

  tools = {
    cabal = "3.2.0.0";
    hlint = "latest";
    haskell-language-server = "latest";
    tasty-discover = "latest";
    stan = "latest";
  };

  # Enable githooks
  shellHook = ''
    ${pre-commit-check.shellHook}
  '';

  buildInputs = [
    # Haskell formatter
    ormolu
    # Allow to pinpoint version for nix and haskell.nix
    niv
    # Haskell dead code detection
    pkgs.haskellPackages.weeder
    pkgs.haskellPackages.tasty-discover
  ] ++ aliases;

  # Prevents cabal from choosing alternate plans, so that
  # *all* dependencies are provided by Nix.
  exactDeps = true;

  # Example of envrionment variable define now in PATH
  ENVIRONMENT = "DEV";
}
