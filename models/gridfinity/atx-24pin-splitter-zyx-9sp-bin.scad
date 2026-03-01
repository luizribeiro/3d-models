include <lib/gridfinity.scad>

// ATX 24-pin Power Supply Splitter (ZYX-9SP) bin
// 3x2 Gridfinity footprint, mostly solid with one custom pocket.
//
// Part envelope (provided):
// - X (width):  100 mm
// - Y (depth):   70 mm
// - Z (height):  28 mm
//
// Design notes:
// - Pocket is centered and slightly oversized for easy insertion/removal.
// - Two side scoops (left/right) are subtracted to improve finger grip.

// -------- User-tunable settings --------
BIN_UNITS_X = 3;
BIN_UNITS_Y = 2;
BIN_UNITS_Z = 5; // 35 mm tall bin (7 mm grid units)

INCLUDE_LIP = true;
ENABLE_MAGNET_HOLES = true;
ONLY_CORNER_HOLES = false;

PART_SIZE_MM = [100, 70, 28];
CLEARANCE_MM = [2.0, 2.0, 1.5];   // per-side XY, plus total Z headroom

FINGER_SCOOP_DIAMETER = 30;        // base diameter before axis scaling
FINGER_SCOOP_SCALE = [0.50, 1.55, 0.85]; // [X,Y,Z] slightly bigger X, same Y, shallower Z
FINGER_SCOOP_X_INSET = 1.2;        // move scoop center inward from side wall to avoid outer-wall clipping
FINGER_SCOOP_CENTER_ON_TOP = true; // true: scoop center sits on top opening plane (z=0)
FINGER_SCOOP_TOP_EXPOSURE = 4;     // used only when CENTER_ON_TOP=false
FINGER_SCOOP_Z_BIAS = 4.0;         // fine vertical tweak (positive moves up)

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

module splitter_pocket(
  part_size = PART_SIZE_MM,
  clearance = CLEARANCE_MM,
  scoop_d = FINGER_SCOOP_DIAMETER,
  scoop_scale = FINGER_SCOOP_SCALE,
  scoop_x_inset = FINGER_SCOOP_X_INSET,
  scoop_center_on_top = FINGER_SCOOP_CENTER_ON_TOP,
  scoop_top_exposure = FINGER_SCOOP_TOP_EXPOSURE,
  scoop_z_bias = FINGER_SCOOP_Z_BIAS
) {
  pocket_size = [
    part_size.x + clearance.x * 2,
    part_size.y + clearance.y * 2,
    part_size.z + clearance.z
  ];

  pocket_depth = pocket_size.z;

  // Main rectangular pocket (top open, extends downward)
  translate([-pocket_size.x / 2, -pocket_size.y / 2, -pocket_depth])
    cube([pocket_size.x, pocket_size.y, pocket_depth + TOLLERANCE]);

  // Finger scoops on left/right of the part area.
  // Ellipsoidal profile: compressed in X, stretched in Y.
  // Center is inset slightly so we keep more exterior side wall thickness.
  // Optional vertical placement modes:
  // - center_on_top=true  => scoop center on top opening plane (z=0)
  // - center_on_top=false => use top exposure amount in mm
  scoop_r = scoop_d / 2;
  scoop_z = (scoop_center_on_top ? 0 : -(scoop_r * scoop_scale.z - scoop_top_exposure)) + scoop_z_bias;
  for (side = [-1, 1])
    translate([side * (pocket_size.x / 2 - scoop_x_inset), 0, scoop_z])
      scale(scoop_scale)
        sphere(d = scoop_d);
}

bin_render(bin1) {
  splitter_pocket();
}
