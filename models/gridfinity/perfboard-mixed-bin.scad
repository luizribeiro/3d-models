// Model purpose: Compact Gridfinity bin for mixed perfboard inventory with one dedicated compartment per board size.
// Designed from rectangle packing to minimize footprint while preserving ~1.25 mm clearance per side around each board.
include <lib/gridfinity.scad>

// -------- Bin settings --------
BIN_UNITS_X = 4;
BIN_UNITS_Y = 4;
BIN_UNITS_Z = 4; // ~19.8 mm usable depth with lip enabled

INCLUDE_LIP = true;
ENABLE_MAGNET_HOLES = true;
ONLY_CORNER_HOLES = false;

// Keep enough wall between adjacent pockets.
DIVIDER_GAP_MM = d_div; // 1.2 mm

// Per-compartment XY allowance applied during packing.
BOARD_CLEARANCE_TOTAL_MM = 2.5; // ~=1.25 mm per side

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
  grid_size = [BIN_UNITS_X, BIN_UNITS_Y],
  height_mm = height(BIN_UNITS_Z, 0, false),
  include_lip = INCLUDE_LIP,
  only_corners = ONLY_CORNER_HOLES,
  hole_options = hole_options
);

// Helper: cut a compartment using bottom-left coordinates in infill space.
module cut_from_bottom_left(infill, x, y, w, h, style_tab = 5) {
  translate([
    -infill.x / 2 + x + w / 2,
    -infill.y / 2 + y + h / 2,
    0
  ])
  cut_compartment_auto(
    size_mm = [w, h, infill.z],
    style_tab = style_tab,
    tab_top_left_only = false,
    scoop_percent = 0
  );
}

bin_render(bin1) {
  infill = bin_get_infill_size_mm(bin1); // expected ~= [165.6, 165.6, 19.8]

  // Aligned 2-row layout (all dividers on a clean grid with 1.2 mm walls).
  // Bottom row height is shared; top row stretches fully to the outer edge.
  // Compartments map to board groups:
  // B: 90.15 x 70.1 (qty 4)
  // D: 60.0  x 40.1 (qty 8) rotated
  // C: 70.3  x 50.1 (qty 5) rotated
  // E: 70.1  x 30.1 (qty 10) rotated
  // F: 80.15 x 20.35 (qty 10) rotated
  // A: 81.5  x 50.8 (qty 3) rotated

  // ----- Bottom row (y = 0 .. 72.6) -----
  // B pocket (largest) - widened for easier grabbing.
  cut_from_bottom_left(infill, 0.0,   0.0, 111.10, 72.60);

  // D pocket (rotated) - same row height as B for aligned divider line.
  cut_from_bottom_left(infill, 112.3, 0.0,  53.30, 72.60);

  // ----- Top row (y = 73.8 .. 165.6) -----
  // C pocket (rotated) - stretches to top edge.
  cut_from_bottom_left(infill, 0.0,   73.8, 52.60, 91.80);

  // E pocket (rotated) - stretches to top edge.
  cut_from_bottom_left(infill, 53.8,  73.8, 32.60, 91.80);

  // F pocket (rotated) - stretches to top edge.
  cut_from_bottom_left(infill, 87.6,  73.8, 23.50, 91.80);

  // A pocket (rotated) - rightmost top pocket to outer edge.
  cut_from_bottom_left(infill, 112.3, 73.8, 53.30, 91.80);
}
