$fn = 500;

// general parameters
TAPE_THICKNESS = 2;
CAP_THICKNESS = 3;
CAP_HEIGHT = 28 + CAP_THICKNESS;
LID_THICKNESS = 2;
LID_HEIGHT = 5 + LID_THICKNESS;
EPS = 1e-2;

// redcat 71
INNER_DIAMETER = 85;
OUTER_DIAMETER = 104 + TAPE_THICKNESS*2;

// uniguide 31
//INNER_DIAMETER = 38;
//OUTER_DIAMETER = 40 + TAPE_THICKNESS*2;

module cap() {
  difference() {
    union() {
      difference() {
        cylinder(h=CAP_HEIGHT, d=OUTER_DIAMETER + CAP_THICKNESS*2);
        translate([0, 0, -EPS])
          cylinder(h=CAP_HEIGHT + EPS*2, d=OUTER_DIAMETER);
      }
      cylinder(h=CAP_THICKNESS, d=OUTER_DIAMETER + CAP_THICKNESS*2);
    }
    translate([0, 0, -EPS])
      cylinder(h=CAP_HEIGHT + EPS*2, d=INNER_DIAMETER);
  }
}

module cutter() {
  difference() {
    cylinder(h=CAP_THICKNESS, d=OUTER_DIAMETER + CAP_THICKNESS*2);
    translate([0, 0, -EPS])
      cylinder(h=CAP_THICKNESS + EPS*2, d=OUTER_DIAMETER);
  }
}

module ring() {
  difference() {
    cylinder(h=CAP_THICKNESS, d=OUTER_DIAMETER);
    translate([0, 0, -EPS])
      cylinder(h=CAP_THICKNESS + EPS*2, d=INNER_DIAMETER);
  }
}

module lid() {
  difference() {
    cylinder(h=LID_HEIGHT, d=OUTER_DIAMETER + CAP_THICKNESS*2 + LID_THICKNESS*2);
    translate([0, 0, EPS + LID_THICKNESS])
      cylinder(h=LID_HEIGHT, d=OUTER_DIAMETER + CAP_THICKNESS*2);
  }
}

cap();
//ring();
//lid();
//cutter();
