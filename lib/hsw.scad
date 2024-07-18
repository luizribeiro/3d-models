EPS = 0.01;

module hsw_plug() {
  PLUG_HEIGHT = 13.4;
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
  thickness = 2
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
        [inner_width + thickness, inner_depth + thickness, inner_height + thickness], rounding=1,
        edges=edges,
        anchor=BOTTOM
    ) {
      position(BACK) orient(BACK) hsw_plug();
    };

    up(thickness) {
      cuboid(
          [inner_width, inner_depth, inner_height + EPS], rounding=1,
          edges=edges,
          anchor=BOTTOM
      );
    }
  }
}
