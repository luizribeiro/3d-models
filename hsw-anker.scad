include <lib/base.scad>
include <lib/hsw.scad>

// holds an anker 511 charger (nano pro)

difference() {
  hsw_box(
    inner_width = 28,
    inner_depth = 28,
    inner_height = 10,
    thickness = 2
  );

  cuboid([16, 16, INF], rounding=2);
}
