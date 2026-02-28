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
