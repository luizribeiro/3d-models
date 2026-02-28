include <lib/gridfinity.scad>

// Jabinco Switch Bin
// 2x2 Gridfinity bin for SPST On/Off Mini Boat Rocker Switches.
// Uses a centered front tab sized well for 12mm label tape.

// -------- User-tunable settings --------
GRID_UNITS_X = 2;                  // Bin footprint in Gridfinity units (X)
GRID_UNITS_Y = 2;                  // Bin footprint in Gridfinity units (Y)
GRID_UNITS_Z = 4;                  // Height in 7mm units (set 5 for a taller version)

INCLUDE_LIP = true;                // true = stackable lip; false = no lip
ENABLE_MAGNET_HOLES = true;        // true = bottom magnet pockets

// Render/detail quality. Lower = faster; higher = smoother curves.
$fa = 4;
$fs = 0.25;

// Bottom hole configuration (magnets/screws/refined style).
hole_options = bundle_hole_options(
  refined_hole = false,            // Use classic holes, not refined variant
  magnet_hole = ENABLE_MAGNET_HOLES,
  screw_hole = false,              // No screw holes in this version
  crush_ribs = false,              // No crush ribs for magnets
  chamfer = true,                  // Add insertion chamfer to hole edges
  supportless = false              // Standard hole profile
);

// Build the 2x2 bin shell.
bin1 = new_bin(
  grid_size = [GRID_UNITS_X, GRID_UNITS_Y],
  // height(z, gridz_define, enable_zsnap)
  // gridz_define=0 means z is in 7mm units.
  // enable_zsnap=false keeps the exact requested unit count.
  height_mm = height(GRID_UNITS_Z, 0, false),
  include_lip = INCLUDE_LIP,
  hole_options = hole_options
);

// Cut a single large compartment spanning the whole bin interior.
// style_tab = 3 => centered label tab.
bin_render(bin1) {
  cut_compartment_auto(
    size_mm = bin_get_infill_size_mm(bin1),
    style_tab = 3,
    tab_top_left_only = false,     // Ignored here since there is only one compartment
    scoop_percent = 0              // Flat floor (no scoop)
  );
}
