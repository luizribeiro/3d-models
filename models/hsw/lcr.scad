// Model purpose: HSW holder for an LCR meter, designed to support the instrument body while allowing easy grab-and-go use at the bench.
// Includes wall plug placement tuned for the meter size and expected handling load.
include <lib/hsw.scad>

// holds a lcr research's lcr pro case

box_container(
  inner_depth = 25.8,
  inner_width = 53,
  inner_height = 40,
  thickness = 2,
  corner_radius = 3
) {
  position(BACK) orient(BACK) hsw_vertical_plugs(2);
}
