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
  OPENSCADPATH="$PWD:$PWD/lib:${OPENSCADPATH:-}" {{openscad}} -o "$out" "$in"
  echo "$out"

# Open STL in Bambu Studio, or render SCAD to STL first then open.
bambu file:
  #!/usr/bin/env bash
  set -euo pipefail

  in="{{file}}"

  if [[ ! -f "$in" && -f "{{models_dir}}/{{file}}" ]]; then
    in="{{models_dir}}/{{file}}"
  fi

  if [[ ! -f "$in" ]]; then
    echo "error: file not found: {{file}}" >&2
    exit 1
  fi

  ext="${in##*.}"
  ext="${ext,,}"

  case "$ext" in
    stl)
      target="$in"
      ;;
    scad)
      if [[ "$in" == "{{models_dir}}"/* ]]; then
        rel="${in#{{models_dir}}/}"
        target="/tmp/3d-models-renders/${rel%.scad}.stl"
      else
        target="/tmp/3d-models-renders/$(basename "${in%.scad}").stl"
      fi

      mkdir -p "$(dirname "$target")"
      OPENSCADPATH="$PWD:$PWD/lib:${OPENSCADPATH:-}" {{openscad}} -o "$target" "$in"
      ;;
    *)
      echo "error: unsupported extension '$ext' (expected .stl or .scad)" >&2
      exit 1
      ;;
  esac

  app="${BAMBU_STUDIO_APP:-}"
  if [[ -n "$app" ]]; then
    open -a "$app" "$target"
  else
    if open -a "Bambu Studio" "$target" 2>/dev/null; then
      :
    elif open -a "BambuStudio" "$target" 2>/dev/null; then
      :
    elif [[ -d "/Applications/Bambu Studio.app" ]]; then
      open -a "/Applications/Bambu Studio.app" "$target"
    elif [[ -d "/Applications/BambuStudio.app" ]]; then
      open -a "/Applications/BambuStudio.app" "$target"
    else
      echo "error: could not find Bambu Studio app. Set BAMBU_STUDIO_APP to the app name/path (e.g. BAMBU_STUDIO_APP='BambuStudio')." >&2
      exit 1
    fi
  fi

  echo "$target"

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

  log="$(mktemp)"
  if ! OPENSCADPATH="$PWD:$PWD/lib:${OPENSCADPATH:-}" {{openscad}} -o "$out" "$in" 2> >(tee "$log" >&2); then
    rm -f "$log"
    exit 1
  fi

  if grep -q '^WARNING:' "$log"; then
    echo "error: OpenSCAD warnings found in $in" >&2
    rm -f "$log"
    exit 1
  fi

  rm -f "$log"
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

  OPENSCADPATH="$PWD:$PWD/lib:${OPENSCADPATH:-}" {{openscad}} --autocenter --viewall --imgsize=1400,1000 --projection=p --camera=0,0,0,55,0,25,450 -o "${base}-iso.png" "$in"
  OPENSCADPATH="$PWD:$PWD/lib:${OPENSCADPATH:-}" {{openscad}} --autocenter --viewall --imgsize=1400,1000 --projection=p --camera=0,0,0,90,0,0,450 -o "${base}-front.png" "$in"
  OPENSCADPATH="$PWD:$PWD/lib:${OPENSCADPATH:-}" {{openscad}} --autocenter --viewall --imgsize=1400,1000 --projection=p --camera=0,0,0,90,0,90,450 -o "${base}-side.png" "$in"

  echo "${base}-iso.png"
  echo "${base}-front.png"
  echo "${base}-side.png"
