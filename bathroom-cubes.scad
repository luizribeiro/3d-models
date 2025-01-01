include <lib/BOSL2/std.scad>

EPS = 0.01;

ALL_EDGES = [
  FRONT + RIGHT,
  FRONT + LEFT,
  BACK + RIGHT,
  BACK + LEFT,
];

// bottom is 3mm shorter than the top
BOTTOM_DIFFERENCE = 3;

module container(
  inner_width,
  inner_height,
  inner_depth,
  thickness,
  corner_radius
) {

  difference() {
    prismoid(
      [inner_width + thickness * 2 - BOTTOM_DIFFERENCE, inner_depth + thickness * 2 - BOTTOM_DIFFERENCE],
      [inner_width + thickness * 2, inner_depth + thickness * 2],
      inner_height + thickness,
      rounding=corner_radius
    ) children();

    up(thickness) {
      prismoid(
        [inner_width - BOTTOM_DIFFERENCE, inner_depth - BOTTOM_DIFFERENCE],
        [inner_width, inner_depth],
        inner_height + EPS,
        rounding=corner_radius - thickness
      );
    }
  }
}

container(
  inner_width=67.5,
  inner_height=47,
  inner_depth=67.5,
  thickness=4.2,
  corner_radius=12
);
