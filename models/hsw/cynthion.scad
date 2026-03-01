// Model purpose: HSW wall holder for Cynthion hardware, shaped to retain the board/device while exposing it for easy insertion and removal.
// Provides a dedicated storage location that integrates with the same modular wall system as your other lab tools.
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
