# 3d-models

A personal collection of 3D-printable models built with [OpenSCAD](https://www.openscad.org/).

## Repository layout

- `models/` — source `.scad` files
  - `models/gridfinity/`
  - `models/hsw/`
  - `models/misc/`
- `lib/` — shared OpenSCAD libraries/wrappers used by models
- `renders/` — rendered artifacts (`.stl`, `.png`)

## Prerequisites

Recommended (reproducible):

- [devenv](https://devenv.sh/)
- [direnv](https://direnv.net/)

Then run:

```bash
direnv allow
```

This loads the dev shell defined in `devenv.nix` (OpenSCAD, just, etc).

## Common workflow

List models:

```bash
just list
just list gridfinity
```

Check a model parses/compiles:

```bash
just check gridfinity/jabinco-switch-bin.scad
```

Render STL:

```bash
# Default output goes to /tmp/3d-models-renders/...
just render gridfinity/jabinco-switch-bin.scad

# Or choose an explicit output path
just render gridfinity/jabinco-switch-bin.scad renders/gridfinity/jabinco-switch-bin.stl
```

Generate preview PNGs (iso/front/side):

```bash
# Default output base goes to /tmp/3d-models-previews/...
just preview gridfinity/jabinco-switch-bin.scad

# Or choose an explicit output base
just preview gridfinity/jabinco-switch-bin.scad renders/gridfinity/jabinco-switch-bin
```

## Notes

- Treat `.scad` files as the source of truth.
- Keep generated artifacts under `renders/` when you want to keep them in the repo.
- If OpenSCAD hangs, kill stale processes and re-run from a clean shell.
