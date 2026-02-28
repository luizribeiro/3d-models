{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    openscad
    openscad-lsp
    pre-commit
    just
  ];

  enterShell = ''
    echo "3d-models devenv ready"
    openscad --version
  '';
}
