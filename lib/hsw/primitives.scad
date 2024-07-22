include <consts.scad>

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

module box_container_with_bins(
  num_bins,
  bin_width,
  inner_height,
  inner_depth,
  thickness,
  corner_radius,
  separator_width,
) {
  assert(num_bins >= 2, "num_bins must be at least 2");

  INNER_WIDTH = bin_width * num_bins + (num_bins-1) * separator_width;

  box_container(
    inner_width = INNER_WIDTH,
    inner_height = inner_height,
    inner_depth = inner_depth,
    thickness = thickness,
    corner_radius = corner_radius
  ) children();

  // TODO: make sure that separators don't bleed out into the corners
  for (i = [0:num_bins-2]) {
    separator_pos = separator_width/2 + INNER_WIDTH / 2
        - (i + 1) * (bin_width + separator_width);
    left(separator_pos) fwd(inner_depth/2)
      // TODO: is this thickness * 2 correct?
      cube([separator_width, inner_depth, inner_height + thickness * 2]);
  }
}
