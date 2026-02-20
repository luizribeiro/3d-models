include <lib/gridfinity.scad>

// Carvera Air wired probe shank holder
// 1x1 Gridfinity bin with 4 shank sockets (2x2 pattern)

GRID_UNITS_X = 1;
GRID_UNITS_Y = 1;
GRID_UNITS_Z = 3;

SHANK_SCREW_DIAMETER = 5.2;
SHANK_SCREW_LENGTH = 4;

SHANK_RING_DIAMETER = 8;
SHANK_RING_LENGTH = 2;

// Increase for looser fit
CLEARANCE = 0.25;

// Smoother cylinders for pocket walls
$fa = 3;
$fs = 0.20;

module shank_socket(
  screw_d = SHANK_SCREW_DIAMETER,
  screw_len = SHANK_SCREW_LENGTH,
  ring_d = SHANK_RING_DIAMETER,
  ring_len = SHANK_RING_LENGTH,
  clearance = CLEARANCE
) {
  screw_r = (screw_d + clearance) / 2;
  ring_r = (ring_d + clearance) / 2;

  total_depth = screw_len + ring_len;

  // Screw section (deeper, narrower)
  translate([0, 0, -total_depth])
    cylinder(h = screw_len + TOLLERANCE, r = screw_r);

  // Ring section (upper, straight counterbore)
  translate([0, 0, -ring_len])
    cylinder(h = ring_len + TOLLERANCE, r = ring_r);
}

bin1 = new_bin(
  grid_size = [GRID_UNITS_X, GRID_UNITS_Y],
  height_mm = height(GRID_UNITS_Z, 0, false),
  include_lip = true,
  hole_options = bundle_hole_options(
    refined_hole = false,
    magnet_hole = true,
    screw_hole = false,
    crush_ribs = false,
    chamfer = true,
    supportless = false
  )
);

bin_render(bin1) {
  bin_subdivide(bin1, [2, 2]) {
    shank_socket();
  }
}
