include <lib/hsw.scad>

// holds four scope probes

NUM_BINS = 4;

BIN_WIDTH = 25;
SEPARATOR_WIDTH = 2;

BOX_DEPTH = 145;
BOX_HEIGHT = 56;
BOX_THICKNESS = 3;

difference() {
  box_container_with_bins(
    num_bins = NUM_BINS,
    bin_width = BIN_WIDTH,
    inner_height = 56,
    inner_depth = BOX_DEPTH,
    thickness = BOX_THICKNESS,
    corner_radius = 2,
    separator_width = SEPARATOR_WIDTH
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

  xrot(20) up(BOX_HEIGHT * 0.8) cube([INF, INF, INF], anchor=BOTTOM);
}
