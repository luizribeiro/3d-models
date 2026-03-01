// Model purpose: Dovetail mount block for integrating a Pegasus Astro Pocket Powerbox Advance Gen 2 setup into a standard astrophotography dovetail ecosystem.
// Provides screw holes and a relief channel so the part can be bolted down cleanly while preserving clearance for cabling/strap routing.
$fn = 100;
EPS = 1e-2;
DOVETAIL_LENGTH = 45;
DOVETAIL_BOTTOM_WIDTH = 33;
DOVETAIL_TOP_WIDTH = 21;
DOVETAIL_HEIGHT = 9;
DOVETAIL_SCREW_DISTANCE = 27.7;
DOVETAIL_EXTRA_HEIGHT = 12;
DOVETAIL_VELCRO_GAP_THICKNESS = 2;
DOVETAIL_VELCRO_GAP_WIDTH = 16;

module dovetail_mount_screw_hole() {
  total_height = DOVETAIL_HEIGHT + DOVETAIL_EXTRA_HEIGHT;
  rotate([-90, 0, 0])
    cylinder(h=total_height / 2, d=7.5);
  rotate([-90, 0, 0])
    cylinder(h=total_height * 2, d=3.1);
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

    translate([-DOVETAIL_VELCRO_GAP_WIDTH/2 + DOVETAIL_BOTTOM_WIDTH/2, (DOVETAIL_HEIGHT + DOVETAIL_EXTRA_HEIGHT)/2, -8])
      rotate([0, 0, 90])
      rotate([90, 0, 0])
      rotate_extrude(angle=180)
      translate([10, 0, 0])
      square([DOVETAIL_VELCRO_GAP_THICKNESS, DOVETAIL_VELCRO_GAP_WIDTH]);
  }
}

dovetail_mount();
