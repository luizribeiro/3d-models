$fn = 100;
EPS = 1e-2;
DOVETAIL_LENGTH = 40;
DOVETAIL_BOTTOM_WIDTH = 32;
DOVETAIL_TOP_WIDTH = 20;
DOVETAIL_HEIGHT = 9;
DOVETAIL_SCREW_DISTANCE = 27.7;
DOVETAIL_EXTRA_HEIGHT = 10;

module dovetail_mount_screw_hole() {
  total_height = DOVETAIL_HEIGHT + DOVETAIL_EXTRA_HEIGHT;
  rotate([-90, 0, 0])
    cylinder(h=total_height / 2, d=7.5);
  rotate([-90, 0, 0])
    cylinder(h=total_height * 2, d=3);
}

module dovetail_mount() {
  difference() {
    linear_extrude(DOVETAIL_LENGTH)
      polygon([
        [0, 0],
        [DOVETAIL_BOTTOM_WIDTH, 0],
        [DOVETAIL_BOTTOM_WIDTH / 2 + DOVETAIL_TOP_WIDTH / 2, DOVETAIL_HEIGHT],
        [DOVETAIL_BOTTOM_WIDTH / 2 + DOVETAIL_TOP_WIDTH / 2, DOVETAIL_HEIGHT + DOVETAIL_EXTRA_HEIGHT],
        [DOVETAIL_BOTTOM_WIDTH / 2 - DOVETAIL_TOP_WIDTH / 2, DOVETAIL_HEIGHT + DOVETAIL_EXTRA_HEIGHT],
        [DOVETAIL_BOTTOM_WIDTH / 2 - DOVETAIL_TOP_WIDTH / 2, DOVETAIL_HEIGHT],
      ]);
    translate([DOVETAIL_BOTTOM_WIDTH / 2, -EPS, DOVETAIL_LENGTH / 2 - DOVETAIL_SCREW_DISTANCE / 2])
      dovetail_mount_screw_hole();
    translate([DOVETAIL_BOTTOM_WIDTH / 2, -EPS, DOVETAIL_LENGTH / 2 + DOVETAIL_SCREW_DISTANCE / 2])
      dovetail_mount_screw_hole();
  }
}

dovetail_mount();
