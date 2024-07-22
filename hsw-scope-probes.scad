include <lib/base.scad>
include <lib/hsw.scad>

// holds four scope probes

NUM_BINS = 4;

BIN_WIDTH = 25;
SEPARATOR_WIDTH = 2;

BOX_DEPTH = 145;
BOX_HEIGHT = 56;
BOX_THICKNESS = 3;

INNER_WIDTH = BIN_WIDTH * NUM_BINS + (NUM_BINS-1) * SEPARATOR_WIDTH;

difference() {
  union() {
    box_container(
      inner_width = INNER_WIDTH,
      inner_height = 56,
      inner_depth = BOX_DEPTH,
      thickness = BOX_THICKNESS,
      corner_radius = 2
    ) {
      left(HSW_X_DISTANCE) {
        up(HSW_Y_DISTANCE/2) position(BACK) orient(BACK) hsw_plug();
        down(HSW_Y_DISTANCE/2) position(BACK) orient(BACK) hsw_plug();
      }
      right(HSW_X_DISTANCE) {
        up(HSW_Y_DISTANCE/2) position(BACK) orient(BACK) hsw_plug();
        down(HSW_Y_DISTANCE/2) position(BACK) orient(BACK) hsw_plug();
      }
    }

    // separators
    for (i = [0:NUM_BINS-2]) {
      separator_pos = SEPARATOR_WIDTH/2 + INNER_WIDTH / 2
          - (i + 1) * (BIN_WIDTH + SEPARATOR_WIDTH);
      left(separator_pos) fwd(BOX_DEPTH/2)
        cube([SEPARATOR_WIDTH, BOX_DEPTH, BOX_HEIGHT + BOX_THICKNESS * 2]);
    }
  }

  xrot(20) up(BOX_HEIGHT * 0.8) cube([INF, INF, INF], anchor=BOTTOM);
}
