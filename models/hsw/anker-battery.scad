include <lib/hsw.scad>

// holds a powercore slim 10000 pd

box_container(
  inner_depth = 15.5,
  inner_width = 69,
  inner_height = 50,
  thickness = 3,
  corner_radius = 3
) {
  position(BACK) orient(BACK) hsw_horizontal_plugs(2);
}
