{ pkgs, ... }:

let
  scadCheckHook = pkgs.writeShellScript "scad-check-hook" ''
    set -euo pipefail

    for f in "$@"; do
      [[ "$f" == *.scad ]] || continue
      [[ -f "$f" ]] || continue

      echo "Checking $f"

      if [[ "$f" == models/* ]]; then
        just check "$f"
      else
        out="/tmp/3d-models-parse/''${f%.scad}.csg"
        mkdir -p "$(dirname "$out")"
        openscad -o "$out" "$f"
        echo "ok: $f"
      fi
    done
  '';
in
{
  packages = with pkgs; [
    git
    openscad
    openscad-lsp
    pre-commit
    just
  ];

  git-hooks.hooks.scad-check = {
    enable = true;
    name = "scad-check";
    entry = "${scadCheckHook}";
    language = "system";
    files = "\\.scad$";
  };

  enterShell = ''
    echo "3d-models devenv ready"
    openscad --version
    echo "pre-commit hooks are managed by devenv"
  '';
}
