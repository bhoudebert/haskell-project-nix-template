with import <nixpkgs> { };

let
  # TODO: replace this with a simple ormolu --mode inplace $(find src/ test/ benchmark/ -name '*.hs')
  # Run ormolu with a predefined src/ target
  ormolu-src-wrapped = pkgs.writeScriptBin "ormolu-src" ''
    ormolu --mode inplace $(find src/ test/ -name '*.hs')
    echo "Ormolu has been runned"
  '';

  stan-hie-wrapped = pkgs.writeScriptBin "stan-hie" ''
    stan --hiedir=.hie-files report
  '';

in
[
  ormolu-src-wrapped
  stan-hie-wrapped
]
