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

# Pretty printer + AMS dashboard (with filament color swatches).
status:
  #!/usr/bin/env bash
  set -euo pipefail

  if ! command -v bambu-cli >/dev/null 2>&1; then
    echo "error: bambu-cli not found in PATH" >&2
    echo "hint: enter devenv shell or install bambu-cli" >&2
    exit 1
  fi

  status_raw="$(bambu-cli status)"
  ams_raw="$(bambu-cli ams status)"

  state="$(awk -F': ' '/^State:/ {print $2}' <<<"$status_raw")"
  progress_line="$(awk -F': ' '/^Progress:/ {print $2}' <<<"$status_raw")"
  temps="$(awk -F': ' '/^Temps:/ {print $2}' <<<"$status_raw")"
  remaining="$(awk -F': ' '/^Remaining:/ {print $2}' <<<"$status_raw")"
  file="$(awk -F': ' '/^File:/ {print $2}' <<<"$status_raw")"
  light="$(awk -F': ' '/^Light:/ {print $2}' <<<"$status_raw")"
  error="$(awk -F': ' '/^Error:/ {print $2}' <<<"$status_raw")"

  percent="0"
  progress_suffix=""
  if [[ "$progress_line" =~ ^([0-9]+)%(.*)$ ]]; then
    percent="${BASH_REMATCH[1]}"
    progress_suffix="${BASH_REMATCH[2]}"
  fi

  declare -a temps_nonzero=()
  for part in $temps; do
    if [[ "$part" =~ ^([^=]+)=(-?[0-9]+([.][0-9]+)?)C$ ]]; then
      label="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      if [[ ! "$value" =~ ^-?0([.]0+)?$ ]]; then
        temps_nonzero+=("${label}=${value}C")
      fi
    fi
  done

  temps_display=""
  if (( ${#temps_nonzero[@]} > 0 )); then
    temps_display="${temps_nonzero[*]}"
  fi

  bar_width=24
  fill=$(( percent * bar_width / 100 ))
  empty=$(( bar_width - fill ))
  printf -v fill_bar '%*s' "$fill" ''
  fill_bar="${fill_bar// /█}"
  printf -v empty_bar '%*s' "$empty" ''
  empty_bar="${empty_bar// /░}"

  swatch() {
    local hex="$1"
    hex="${hex#\#}"
    hex="${hex^^}"
    if [[ ${#hex} -eq 8 ]]; then
      hex="${hex:0:6}"
    fi

    if [[ ! "$hex" =~ ^[0-9A-F]{6}$ ]]; then
      printf '??'
      return
    fi

    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    printf '\033[48;2;%d;%d;%dm  \033[0m' "$r" "$g" "$b"
  }

  echo "Bambu printer"
  echo "────────────────────────────────────────────────────────────────"
  printf "State:      %s\n" "${state:-unknown}"
  printf "Progress:   %s %s%%%s\n" "${fill_bar}${empty_bar}" "$percent" "$progress_suffix"
  if [[ -n "$temps_display" ]]; then
    printf "Temps:      %s\n" "$temps_display"
  fi
  printf "Remaining:  %s\n" "${remaining:-unknown}"
  printf "Light:      %s\n" "${light:-unknown}"
  if [[ -n "$error" && ! "$error" =~ ^0+$ ]]; then
    printf "Error:      %s\n" "$error"
  fi
  printf "File:       %s\n" "${file:-unknown}"
  echo ""
  echo "AMS"
  echo "────────────────────────────────────────────────────────────────"

  current_ams=""
  while IFS= read -r line; do
    if [[ "$line" =~ ^AMS[[:space:]]+([0-9]+):[[:space:]]humidity=([^[:space:]]+)[[:space:]]temp=([^[:space:]]+) ]]; then
      current_ams="${BASH_REMATCH[1]}"
      humidity="${BASH_REMATCH[2]}"
      temp="${BASH_REMATCH[3]}"
      echo "  • AMS ${current_ams}  humidity=${humidity}  temp=${temp}°C"
      continue
    fi

    if [[ "$line" =~ ^[[:space:]]*tray[[:space:]]+([0-9]+): ]]; then
      tray="${BASH_REMATCH[1]}"
      name_part="${line#*name=}"
      name="${name_part%% type=*}"

      material=""
      color=""
      [[ "$line" =~ type=([^[:space:]]+) ]] && material="${BASH_REMATCH[1]}"
      [[ "$line" =~ color=([0-9A-Fa-f]{6,8}) ]] && color="${BASH_REMATCH[1]}"

      block="$(swatch "$color")"
      if [[ -n "$name" ]]; then
        printf "      - tray %s  %b  %-8s  %-10s (%s)\n" "$tray" "$block" "$material" "$name" "$color"
      else
        printf "      - tray %s  %b  %-8s  %s\n" "$tray" "$block" "$material" "$color"
      fi
    fi
  done <<<"$ams_raw"

  echo ""
