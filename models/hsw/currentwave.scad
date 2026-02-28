include <lib/hsw.scad>

// holds a DoTheDiy's CurrentWave

difference() {
  box_container(
    inner_depth = 30.5,
    inner_width = 54.5,
    inner_height = 30,
    thickness = 2,
    corner_radius = 2
  ) {
    position(BACK) orient(BACK) hsw_horizontal_plugs(2);
  }
  up(10) cuboid([47, INF, 60], rounding=2, anchor=BOTTOM + BACK);
}
