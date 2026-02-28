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
