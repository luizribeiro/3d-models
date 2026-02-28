set shell := ["bash", "-euo", "pipefail", "-c"]

openscad := "openscad"
models_dir := "models"

# Show available recipes.
@default:
  just --list

# List models (all, or only under a subdir like `gridfinity`, `hsw`, `misc`).
list subdir='':
  #!/usr/bin/env bash
  set -euo pipefail
  if [[ -z "{{subdir}}" ]]; then
    find {{models_dir}} -type f -name '*.scad' | sort
  else
    find "{{models_dir}}/{{subdir}}" -type f -name '*.scad' | sort
  fi

# Render a model to STL (default output: /tmp/3d-models-renders/...; optional explicit output path).
render model out='':
  #!/usr/bin/env bash
  set -euo pipefail

  if [[ "{{model}}" == "{{models_dir}}"/* ]]; then
    in="{{model}}"
  else
    in="{{models_dir}}/{{model}}"
  fi

  rel="${in#{{models_dir}}/}"

  if [[ -n "{{out}}" ]]; then
    out="{{out}}"
  else
    out="/tmp/3d-models-renders/${rel%.scad}.stl"
  fi

  mkdir -p "$(dirname "$out")"
  {{openscad}} -o "$out" "$in"
  echo "$out"

# Fast compile/parse check only (no STL output).
check model:
  #!/usr/bin/env bash
  set -euo pipefail

  if [[ "{{model}}" == "{{models_dir}}"/* ]]; then
    in="{{model}}"
  else
    in="{{models_dir}}/{{model}}"
  fi

  rel="${in#{{models_dir}}/}"
  out="/tmp/3d-models-parse/${rel%.scad}.csg"

  mkdir -p "$(dirname "$out")"
  {{openscad}} -o "$out" "$in"
  echo "ok: $in"

# Generate ISO/front/side PNG previews (default base: /tmp/3d-models-previews/...; optional explicit base path).
preview model out_base='':
  #!/usr/bin/env bash
  set -euo pipefail

  if [[ "{{model}}" == "{{models_dir}}"/* ]]; then
    in="{{model}}"
  else
    in="{{models_dir}}/{{model}}"
  fi

  rel="${in#{{models_dir}}/}"

  if [[ -n "{{out_base}}" ]]; then
    base="{{out_base}}"
  else
    base="/tmp/3d-models-previews/${rel%.scad}"
  fi

  mkdir -p "$(dirname "$base")"

  {{openscad}} --autocenter --viewall --imgsize=1400,1000 --projection=p --camera=0,0,0,55,0,25,450 -o "${base}-iso.png" "$in"
  {{openscad}} --autocenter --viewall --imgsize=1400,1000 --projection=p --camera=0,0,0,90,0,0,450 -o "${base}-front.png" "$in"
  {{openscad}} --autocenter --viewall --imgsize=1400,1000 --projection=p --camera=0,0,0,90,0,90,450 -o "${base}-side.png" "$in"

  echo "${base}-iso.png"
  echo "${base}-front.png"
  echo "${base}-side.png"
