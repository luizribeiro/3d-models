include <BOSL2/std.scad>
include <lib/hsw.scad>

$fn = $preview ? 20 : 100;

hsw_box(
  inner_width = 63.2,
  inner_height = 40,
  inner_depth = 20.5,
  thickness = 3,
  corner_radius = 4
);
