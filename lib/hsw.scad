include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

EPS = 0.01;
INF = 1e4;

module hsw_plug() {
  PLUG_HEIGHT = 13.3;
  PLUG_LENGTH = 10;
  PLUG_CIRCUMCIRCLE_RADIUS = PLUG_HEIGHT * sqrt(3) / 3;

  cylinder(
    r=PLUG_CIRCUMCIRCLE_RADIUS,
    h=PLUG_LENGTH,
    anchor=BOTTOM,
    $fn=6
  ) children();
}

module box_container(
  inner_width,
  inner_height,
  inner_depth,
  thickness,
  corner_radius,
) {
  edges = [
    BOTTOM + FRONT,
    BOTTOM + BACK,
    BOTTOM + RIGHT,
    BOTTOM + LEFT,
    FRONT + RIGHT,
    FRONT + LEFT,
    BACK + RIGHT,
    BACK + LEFT,
  ];

  difference() {
    cuboid(
        [inner_width + thickness * 2, inner_depth + thickness * 2, inner_height + thickness * 2], rounding=corner_radius,
        edges=edges,
        anchor=BOTTOM
    ) children();

    up(thickness * 2) {
      cuboid(
          [inner_width, inner_depth, inner_height + EPS], rounding=corner_radius,
          edges=edges,
          anchor=BOTTOM
      );
    }
  }
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
      zrot(90) xrot(90) path_extrude(smooth_path(path, size=1)) circle(r=radius, $fn=100);
  }
}
