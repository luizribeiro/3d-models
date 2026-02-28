include <../../lib/hsw.scad>

// holds a hackrf

difference() {
  box_container(
    inner_depth = 19.3,
    inner_width = 79.5,
    inner_height = 40,
    thickness = 2,
    corner_radius = 2
  ) {
    position(BACK) orient(BACK) hsw_horizontal_plugs(2);
  }
  cuboid([72.2, 12, INF], rounding=2, anchor=CENTER);
}
