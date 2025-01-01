include <lib/BOSL2/std.scad>

// dimensions in mm
OUTER_WIDTH = 75.9;
OUTER_HEIGHT = 75.9;

// these are all standardized, but can be configured if needed
OUTER_DEPTH = 51.2;
THICKNESS = 4.2;
CORNER_RADIUS = 12;

// useful constants
EPS = 0.01;
ALL_EDGES = [
  FRONT + RIGHT,
  FRONT + LEFT,
  BACK + RIGHT,
  BACK + LEFT,
];

// use high $fn if we're rendering
$fn = $preview ? 32 : 256;

module container(
  inner_width,
  inner_height,
  inner_depth,
  thickness,
  corner_radius
) {
  // bottom is 3mm shorter than the top
  BOTTOM_DIFFERENCE = 3;

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
  inner_width=OUTER_WIDTH - THICKNESS * 2,
  inner_height=OUTER_DEPTH - THICKNESS,
  inner_depth=OUTER_HEIGHT - THICKNESS * 2,
  thickness=THICKNESS,
  corner_radius=CORNER_RADIUS
);
