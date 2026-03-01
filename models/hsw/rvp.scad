// Model purpose: HSW holder for the RVP+ 100W USB-C charger/power device, sized for stable wall mounting and easy daily access.
// Uses reusable spacing modules so similar power accessories can be adapted with consistent fit and plug geometry.
include <lib/hsw.scad>

// holds a RVP+ 100W charger

difference() {
  box_container(
    inner_width = 33,
    inner_height = 56,
    inner_depth = 69,
    thickness = 3,
    corner_radius = 2
  ) {
    position(BACK) orient(BACK) hsw_vertical_plugs(2);
  }
  fwd(10) up(20) cube([INF, 69, INF], anchor=BOTTOM);
}
