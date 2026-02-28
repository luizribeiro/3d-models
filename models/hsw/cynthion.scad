include <lib/hsw.scad>

// holds a great scott gadgets cynthion

box_container(
  inner_depth = 15.8,
  inner_width = 64,
  inner_height = HSW_PLUG_HEIGHT - 2,
  thickness = 2,
  corner_radius = 3,
  round_all = false
) {
  position(BACK + BOTTOM) orient(BACK) back(HSW_PLUG_HEIGHT / 2)
    hsw_horizontal_plugs(2);
}
