include <lib/base.scad>
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
    up(HSW_Y_DISTANCE/2) position(BACK) orient(BACK) hsw_plug();
    down(HSW_Y_DISTANCE/2) position(BACK) orient(BACK) hsw_plug();
  }
  fwd(10) up(20) cube([INF, 69, INF], anchor=BOTTOM);
}
