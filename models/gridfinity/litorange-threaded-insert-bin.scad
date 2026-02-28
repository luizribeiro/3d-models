include <lib/gridfinity.scad>

// Litorange threaded insert assortment bin
// Kit in reference image: 14 sizes total
//   M4:   6x8, 6x6, 6x4
//   M3:   5x8, 5x6, 5x4, 5x2
//   M2:   3.5x8, 3.5x6, 3.5x4, 3.5x2
//   M2.5: 3.5x5, 3.5x4, 3.5x3
//
// Layout:
// - 4x2 Gridfinity outer bin
// - 7x2 compartments (14 total; one per size)
// - Centered tab on each compartment for 12mm label tape
// - Scoop enabled for easier part pickup

// -------- User-tunable settings --------
BIN_UNITS_X = 4;
BIN_UNITS_Y = 2;
BIN_UNITS_Z = 3;                // set to 4/5 for taller walls

DIVISIONS_X = 7;                // 7 columns
DIVISIONS_Y = 2;                // 2 rows

INCLUDE_LIP = true;
ENABLE_MAGNET_HOLES = true;
ONLY_CORNER_HOLES = false;

SCOOP_PERCENT = 0.85;           // 0 = flat floor, higher = deeper scoop (max 1.0)

// Render quality (tradeoff: speed vs smoothness)
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
  infill = bin_get_infill_size_mm(bin1);
  compartment_size_mm = [
    infill.x / DIVISIONS_X - d_div / 2,
    infill.y / DIVISIONS_Y - d_div / 2,
    infill.z
  ];

  // style_tab = 3 => centered tab (works well with 12mm label tape)
  bin_subdivide(bin1, [DIVISIONS_X, DIVISIONS_Y]) {
    cut_compartment_auto(
      size_mm = compartment_size_mm,
      style_tab = 3,
      tab_top_left_only = false,
      scoop_percent = SCOOP_PERCENT
    );
  }
}

// Suggested label order (left -> right):
// Top row:    M4x6x8 | M4x6x6 | M4x6x4 | M3x5x8 | M3x5x6 | M3x5x4 | M3x5x2
// Bottom row: M2x3.5x8 | M2x3.5x6 | M2x3.5x4 | M2x3.5x2 | M2.5x3.5x5 | M2.5x3.5x4 | M2.5x3.5x3
