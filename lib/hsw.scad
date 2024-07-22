include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <base.scad>
include <hsw/consts.scad>
include <hsw/primitives.scad>

module hsw_plug() {
  PLUG_HEIGHT = 13.3;
  PLUG_LENGTH = 10;

  PLUG_CIRCUMCIRCLE_RADIUS = PLUG_HEIGHT * sqrt(3) / 3;
  path = [
    for (i = [0:5]) [
      PLUG_CIRCUMCIRCLE_RADIUS * cos(i * 60),
      PLUG_CIRCUMCIRCLE_RADIUS * sin(i * 60)
    ]
  ];

  linear_sweep(make_region(path), height=PLUG_LENGTH) children();
}

module hsw_box(
  inner_width = 65.5,
  inner_height = 24,
  inner_depth = 40,
  thickness = 2,
  corner_radius = 1,
) {
  box_container(
    inner_width,
    inner_height,
    inner_depth,
    thickness,
    corner_radius
  ) {
    position(BACK) orient(BACK) hsw_plug();
  }
}

module hsw_hook(path, radius) {
  hsw_plug() {
    attach(TOP, TOP)
      zrot(90) xrot(90) path_extrude(smooth_path(path, size=1)) circle(r=radius);
  }
}
