# 3d-models

[![Models Check](https://github.com/luizribeiro/3d-models/actions/workflows/models-check.yml/badge.svg)](https://github.com/luizribeiro/3d-models/actions/workflows/models-check.yml)

A personal collection of 3D-printable models built with [OpenSCAD](https://www.openscad.org/).

We use [devenv](https://devenv.sh/) for development environment management.

## Repository layout

- `models/` — source `.scad` model files
- `lib/` — shared OpenSCAD libraries/wrappers used by models
- `dependencies/` — external assets imported by some models (e.g. STL/SVG)
- `renders/` — local output directory for generated artifacts (`.stl`, `.png`)

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
- Generated artifacts should generally stay out of git unless intentionally curated.
