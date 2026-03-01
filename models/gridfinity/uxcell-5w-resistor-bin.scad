// Model purpose: Gridfinity bin for Uxcell 5W resistors, sized for resistor body dimensions and quantities typical in your bench inventory.
// Provides repeatable storage and labeling-friendly organization for high-wattage resistors alongside other Gridfinity electronics bins.
include <lib/gridfinity.scad>

// uxcell 5W Metal Oxide Film Resistor Bin
// Pack: 60 pcs, 6 values -> 39R, 47R, 56R, 75R, 82R, 100R (±5%)
// Layout: 6x3 outer bin, split into 2x3 compartments (6 total).
// Each compartment is ~3 units wide x ~1 unit deep.

// -------- User-tunable settings --------
BIN_UNITS_X = 6;
BIN_UNITS_Y = 3;
BIN_UNITS_Z = 4;             // set to 5 for taller walls

DIVISIONS_X = 2;             // 2 columns => each is ~3 units wide
DIVISIONS_Y = 3;             // 3 rows => total 6 compartments

INCLUDE_LIP = true;
ENABLE_MAGNET_HOLES = true;  // set false for much faster render/export
ONLY_CORNER_HOLES = false;   // set true to reduce complexity/time

// Coarser values render faster; can lower later if needed.
$fa = 8;
$fs = 0.6;

hole_options = bundle_hole_options(
  refined_hole = false,
  magnet_hole = ENABLE_MAGNET_HOLES,
  screw_hole = false,
  crush_ribs = false,
  chamfer = true,
  supportless = false
);

bin1 = new_bin(
  grid_size = [BIN_UNITS_X, BIN_UNITS_Y],
  height_mm = height(BIN_UNITS_Z, 0, false),
  include_lip = INCLUDE_LIP,
  only_corners = ONLY_CORNER_HOLES,
  hole_options = hole_options
);

bin_render(bin1) {
  // NOTE: Avoid cgs() for compatibility with older OpenSCAD builds.
  infill = bin_get_infill_size_mm(bin1);
  compartment_size_mm = [
    infill.x / DIVISIONS_X - d_div / 2,
    infill.y / DIVISIONS_Y - d_div / 2,
    infill.z
  ];

  // style_tab = 3 => centered tab on each compartment.
  bin_subdivide(bin1, [DIVISIONS_X, DIVISIONS_Y]) {
    cut_compartment_auto(
      size_mm = compartment_size_mm,
      style_tab = 3,
      tab_top_left_only = false,
      scoop_percent = 0
    );
  }
}

// Suggested labels (example order):
// Top row:    39R | 47R
// Middle row: 56R | 75R
// Bottom row: 82R | 100R
