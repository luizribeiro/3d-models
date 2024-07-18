include <BOSL2/std.scad>

EPS = 0.01;

module hsw_plug() {
  PLUG_HEIGHT = 13.3;
  PLUG_LENGTH = 10;
  PLUG_CIRCUMCIRCLE_RADIUS = PLUG_HEIGHT * sqrt(3) / 3;

  cylinder(
    r=PLUG_CIRCUMCIRCLE_RADIUS,
    h=PLUG_LENGTH,
    anchor=BOTTOM,
    $fn=6
  );
}

module hsw_box(
  inner_width = 65.5,
  inner_height = 24,
  inner_depth = 40,
  thickness = 2,
  corner_radius = 1
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
    ) {
      position(BACK) orient(BACK) hsw_plug();
    };

    up(thickness * 2) {
      cuboid(
          [inner_width, inner_depth, inner_height + EPS], rounding=corner_radius,
          edges=edges,
          anchor=BOTTOM
      );
    }
  }
}

module hsw_hook() {
  cylinder(h=10, r=5, anchor=BOTTOM) {
    position(TOP) hsw_plug();
  }
}
