// Model purpose: HSW holder for a Fanttik vacuum, creating a mounted parking position with appropriate orientation and plug support.
// Balances retention and removal force so the vacuum stays put but can be grabbed quickly for cleanup tasks.
include <lib/hsw.scad>

DIAMETER = 55;
THICKNESS = 4;

difference() {
  cylinder(h=16, d=DIAMETER + THICKNESS)
    fwd(10) yrot(90) position(BACK) orient(BACK) hsw_plug(length=20);
  down(EPS) cylinder(h=INF, d=DIAMETER);
  right(37) cube([60, 60, 60], anchor=CENTER);
  fwd(10) right(25) cube([60, 60, 60], anchor=CENTER);
}
