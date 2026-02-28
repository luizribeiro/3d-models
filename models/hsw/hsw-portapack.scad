include <../../lib/hsw.scad>

// holds a hackrf portapack h2m

difference() {
  box_container(
    inner_depth = 26,
    inner_width = 80.1,
    inner_height = 40,
    thickness = 2,
    corner_radius = 2
  ) {
    position(BACK) orient(BACK) hsw_horizontal_plugs(2);
  }
  left(19) cuboid([32, 25, INF], rounding=2, anchor=CENTER);
  right(19) cuboid([32, 25, INF], rounding=2, anchor=CENTER);
  up(10) cuboid([60, INF, 60], rounding=2, anchor=BOTTOM + BACK);
}
