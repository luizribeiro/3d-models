// Model purpose: Three-part astronomy EL panel mount system (cap, ring, and adapter) used to hold an acrylic diffuser panel and attach it to telescope/optics hardware for flat frames.
// Includes cable pass-through and screw/nut features so the panel assembly is secure, serviceable, and aligned during astrophotography calibration.
$fn = 500;
INCH = 25.4;
EPS = 0.01;
INF = 1000;

TAPE_THICKNESS = 2;

INNER_DIAMETER = 274;
CAP_DEPTH = 38;
CAP_THICKNESS = 3;
CAP_BOTTOM_THICKNESS = 4;
CABLE_HOLE_WIDTH = 24;
CABLE_HOLE_HEIGHT = 7.8;
ACRYLIC_DIAMETER = 268;
ACRYLIC_THICKNESS = 3.7;
ACRYLIC_OVERLAP = 5; // how much the mount ring will cover with the acrylic plate
RING_THICKNESS = 7;

ADAPTER_INNER_DIAMETER = 104 + TAPE_THICKNESS * 2;
ADAPTER_DEPTH = 30;
ADAPTER_SUPPORT_WIDTH = 20;
ADAPTER_SUPPORT_THICKNESS = 10;
ADAPTER_INNER_LIP_WIDTH = 4.5;

SCREW_DISTANCE = 72;
NUT_HEIGHT = 3.2;
NUT_DIAMETER = 8;
SCREW_DIAMETER = 4;

module nut_hole() {
  // TODO: adjust for actual nut and screw size
  translate([0, 0, CAP_BOTTOM_THICKNESS - NUT_HEIGHT])
    cylinder(h = NUT_HEIGHT + EPS, d = NUT_DIAMETER, $fn = 6);
  translate([0, 0, -EPS])
    cylinder(h = CAP_BOTTOM_THICKNESS + 2 * EPS, d = SCREW_DIAMETER);
}

module mount() {
  difference() {
    union() {
      difference() {
        cylinder(h = CAP_DEPTH + CAP_BOTTOM_THICKNESS, d = INNER_DIAMETER + 2 * CAP_THICKNESS);
        translate([0, 0, CAP_BOTTOM_THICKNESS])
          cylinder(h = CAP_DEPTH + EPS, d = INNER_DIAMETER);
        translate([-SCREW_DISTANCE / 2, 0, 0])
          nut_hole();
        translate([ SCREW_DISTANCE / 2, 0, 0])
          nut_hole();
      }
      translate([0, 0, CAP_BOTTOM_THICKNESS]) difference() {
        cylinder(h = ACRYLIC_THICKNESS, d = INNER_DIAMETER);
        translate([0, 0, -EPS])
          cylinder(h = ACRYLIC_THICKNESS + 2*EPS, d = ACRYLIC_DIAMETER);
      }
    }
    translate([0, -CABLE_HOLE_WIDTH/2, CAP_BOTTOM_THICKNESS + EPS])
      cube([INF, CABLE_HOLE_WIDTH, CABLE_HOLE_HEIGHT]);
  }
}

module mount_ring() {
  difference() {
    cylinder(h = RING_THICKNESS, d = INNER_DIAMETER);
    translate([0, 0, -EPS])
      cylinder(h = RING_THICKNESS + 2*EPS, d = ACRYLIC_DIAMETER - 2 * ACRYLIC_OVERLAP);
    translate([0, -CABLE_HOLE_WIDTH/2, -ACRYLIC_THICKNESS + EPS])
      cube([INF, CABLE_HOLE_WIDTH, CABLE_HOLE_HEIGHT]);
  }
}

module adapter() {
  difference() {
    union() {
      translate([0, 0, RING_THICKNESS]) intersection() {
        cylinder(h = ADAPTER_SUPPORT_THICKNESS, d = INNER_DIAMETER);
        union() {
          translate([-INF/2, -ADAPTER_SUPPORT_WIDTH / 2, 0])
          cube([INF, ADAPTER_SUPPORT_WIDTH, ADAPTER_SUPPORT_THICKNESS]);
          rotate([0, 0, 90])
            translate([-INF/2, -ADAPTER_SUPPORT_WIDTH / 2, 0])
            cube([INF, ADAPTER_SUPPORT_WIDTH, ADAPTER_SUPPORT_THICKNESS]);
        }
      }
      cylinder(h = ADAPTER_DEPTH, d = ADAPTER_INNER_DIAMETER + 2 * CAP_THICKNESS);
    }
    translate([0, 0, - EPS])
      cylinder(h = INF, d = ADAPTER_INNER_DIAMETER);
  }
  difference() {
    cylinder(h = CAP_THICKNESS, d=ADAPTER_INNER_DIAMETER);
    translate([0, 0, -EPS])
      cylinder(h = CAP_THICKNESS + 2 * EPS, d=ADAPTER_INNER_DIAMETER - 2 * ADAPTER_INNER_LIP_WIDTH);
  }
}

mount();
translate([0, 0, CAP_BOTTOM_THICKNESS + ACRYLIC_THICKNESS])
  mount_ring();
translate([0, 0, CAP_BOTTOM_THICKNESS + ACRYLIC_THICKNESS])
  adapter();
