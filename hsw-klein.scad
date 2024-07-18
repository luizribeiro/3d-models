include <BOSL2/std.scad>
include <lib/hsw.scad>

$fn = $preview ? 20 : 100;

hsw_box(
  inner_width = 65.5,
  inner_height = 24,
  inner_depth = 40,
  thickness = 3,
  corner_radius = 2
);
