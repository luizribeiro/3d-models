// Model purpose: Gridfinity storage bin for a small XR2206 function-generator kit module.
// Pocket geometry is tuned from provided envelope dimensions for easy insertion/removal.
include <lib/gridfinity.scad>

// XR2206 module envelope (provided by user)
// - Width (X):  71.2 mm
// - Length (Y): 55.2 mm
// - Height (Z): 22.0 mm

// -------- User-tunable settings --------
BIN_UNITS_X = 2;
BIN_UNITS_Y = 2;
BIN_UNITS_Z = 5; // 35 mm tall bin

INCLUDE_LIP = true;
ENABLE_MAGNET_HOLES = true;
ONLY_CORNER_HOLES = false;

PART_SIZE_MM = [71.2, 55.2, 22.0];
CLEARANCE_MM = [1.6, 1.6, 1.5]; // XY = per-side, Z = total headroom

FINGER_SCOOP_DIAMETER = 24;
FINGER_SCOOP_SCALE = [1.25, 0.60, 0.90];
FINGER_SCOOP_Y_INSET = 1.2;
FINGER_SCOOP_Z_BIAS = 1.8;

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

module xr2206_pocket(
  part_size = PART_SIZE_MM,
  clearance = CLEARANCE_MM,
  scoop_d = FINGER_SCOOP_DIAMETER,
  scoop_scale = FINGER_SCOOP_SCALE,
  scoop_y_inset = FINGER_SCOOP_Y_INSET,
  scoop_z_bias = FINGER_SCOOP_Z_BIAS
) {
  pocket_size = [
    part_size.x + clearance.x * 2,
    part_size.y + clearance.y * 2,
    part_size.z + clearance.z
  ];

  pocket_depth = pocket_size.z;

  // Main rectangular pocket (open at top)
  translate([-pocket_size.x / 2, -pocket_size.y / 2, -pocket_depth])
    cube([pocket_size.x, pocket_size.y, pocket_depth + TOLLERANCE]);

  // Front/back finger scoops to help lift the module out.
  // Oriented on Y to avoid thinning the side walls.
  scoop_z = scoop_z_bias;
  for (side = [-1, 1])
    translate([0, side * (pocket_size.y / 2 - scoop_y_inset), scoop_z])
      scale(scoop_scale)
        sphere(d = scoop_d);
}

bin_render(bin1) {
  xr2206_pocket();
}
