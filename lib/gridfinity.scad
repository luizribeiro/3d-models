// Project-level wrapper for Gridfinity Rebuilt.
//
// Usage:
//   include <lib/gridfinity.scad>
//
// Then use exported APIs such as:
//   - new_bin(...), bin_render(...), bin_subdivide(...)
//   - cgs(...), cut_compartment_auto(...), cut_chamfered_cylinder(...)
//   - gridfinityBase(...), gridfinity_base_lite(...)
//   - baseplate_cutter(...), single_baseplate(...)

include <gridfinity-rebuilt-openscad/src/core/standard.scad>

use <gridfinity-rebuilt-openscad/src/core/bin.scad>
use <gridfinity-rebuilt-openscad/src/core/base.scad>
use <gridfinity-rebuilt-openscad/src/core/cutouts.scad>
use <gridfinity-rebuilt-openscad/src/core/gridfinity-baseplate.scad>
use <gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-holes.scad>
use <gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-utility.scad>

use <gridfinity-rebuilt-openscad/src/helpers/grid.scad>
use <gridfinity-rebuilt-openscad/src/helpers/grid_element.scad>
use <gridfinity-rebuilt-openscad/src/helpers/generic-helpers.scad>
use <gridfinity-rebuilt-openscad/src/helpers/list.scad>
