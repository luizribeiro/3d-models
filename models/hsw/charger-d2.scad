// Model purpose: HSW holder for a D2 charger unit, providing a wall-mounted cradle with geometry tailored to the charger body dimensions.
// Intended for stable vertical storage and quick docking/undocking during charging workflows.
include <lib/hsw.scad>

INNER_WIDTH = 61;
INNER_DEPTH = 31;
INNER_HEIGHT = 60;
THICKNESS = 3;
CORNER_RADIUS = 3;

difference() {
  box_container(
    inner_width = INNER_WIDTH,
    inner_height = INNER_HEIGHT,
    inner_depth = INNER_DEPTH,
    thickness = THICKNESS,
    corner_radius = CORNER_RADIUS
  ) {
    position(BACK) orient(BACK) hsw_horizontal_plugs(2);
  }
  fwd(10) up(35) cube([INF, INNER_DEPTH, INF], anchor=BOTTOM);
}
