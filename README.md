# haskell-project-nix-template

WARNING: when renaming the project, be sure to add sources to control, at least `git add`, otherwise `haskell.nix` will not found your cabal file...

## Requirements

- Nix installed (https://nixos.org/download.html)
- cachix
```Config
substituters = https://cache.nixos.org https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=
```
- direnv recommended

Please note that loading the shell is way way longer than invoking the nix build because it is providing the dev environment.

## Nix build & run

You can use Nix or cabal to build.

```Shell
# Without nix
cabal run haskell-project-nix-template-exe
# With Nix
nix-build -A project.haskell-project-nix-template.components.exes.haskell-project-nix-template-exe
```
## Git hooks

Some git hooks has been configured to run automatically over your commit changes.

For now it is composed of ormolu and nixpkgs-fmt.

## Formatting

We are using here `ormolu` but you can switch to stylish haskell if you want without too much fuzz.

An extra alias is also available from shell: `ormolu-src` which will run over the whole project

## Testing

We used hedgehog for property base test, and hunit, tasty for the rest.

Another convention it that, in all Spec file, the module we want to test must be `qualified` imported as `SUT` (Subject/System Under Test) for better and faster use.

### Stan

Stan is a Haskell STatic ANalysis tool: https://github.com/kowainik/stan
```Shell
stan --hiedir=.hie-files report
```
You also have a convenient alias to do that
```Shell
stan-hie
```

## Weeder

Broken for now as it detects everything as non used.

Guess: try to use flake to build it from repository.

## Issue

The shell, for the first time is very very long, and if you changes some things in the shell.nix, like mentioned above it can trigger a full Nix rebuild (like ghc!). Still a direct `nix-build` is very fast (10s something like that depending on your machine).
