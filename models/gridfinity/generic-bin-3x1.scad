// Model purpose: Generic 3x1 Gridfinity bin with a centered label tab and bottom magnet holes for larger parts, kits, or bundled hardware.
// Uses the same wall height as the large divided resistor bin so these bins align visually and functionally with existing storage in this repository.
include <lib/gridfinity.scad>

// Generic 3x1 label-ready bin (same height as uxcell-5w-resistor-bin)
GRID_UNITS_X = 3;
GRID_UNITS_Y = 1;
GRID_UNITS_Z = 4;

INCLUDE_LIP = true;
ENABLE_MAGNET_HOLES = true;
ONLY_CORNER_HOLES = false;

$fa = 6;
$fs = 0.4;

hole_options = bundle_hole_options(
  refined_hole = false,
  magnet_hole = ENABLE_MAGNET_HOLES,
  screw_hole = false,
  crush_ribs = false,
  chamfer = true,
  supportless = false
);

bin1 = new_bin(
  grid_size = [GRID_UNITS_X, GRID_UNITS_Y],
  height_mm = height(GRID_UNITS_Z, 0, false),
  include_lip = INCLUDE_LIP,
  only_corners = ONLY_CORNER_HOLES,
  hole_options = hole_options
);

bin_render(bin1) {
  cut_compartment_auto(
    size_mm = bin_get_infill_size_mm(bin1),
    style_tab = 3,
    tab_top_left_only = false,
    scoop_percent = 0
  );
}
