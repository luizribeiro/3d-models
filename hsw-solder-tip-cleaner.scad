include <lib/hsw.scad>

DEPTH = 19;
DIAMETER = 38;
THICKNESS = 2;
BORDER = 10;

difference() {
  cylinder(d=DIAMETER + 2*THICKNESS, h=DEPTH + THICKNESS, anchor=CENTER) {
    position(TOP) hsw_plug();
  };
  down(THICKNESS) back(DIAMETER/2) cube([DIAMETER + 2*THICKNESS, DIAMETER, DEPTH + EPS], anchor=CENTER);
  down(THICKNESS/2) cylinder(d=DIAMETER, h=DEPTH - THICKNESS, anchor=CENTER);
  down(THICKNESS) cylinder(d=DIAMETER - BORDER, h=DEPTH, anchor=CENTER);
}
