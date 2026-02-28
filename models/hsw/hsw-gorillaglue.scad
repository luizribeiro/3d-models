include <../../lib/hsw.scad>

// holds an upside down gorilla super glue gel xl

HEIGHT = 42;
THICKNESS = 5;
INNER_DIAMETER = 22;
HOLE_DIAMETER = 11.5;

difference() {
  cylinder(d=INNER_DIAMETER+THICKNESS, h=HEIGHT) {
    position(BACK) orient(BACK) down(10) hsw_plug(length=20);
  }
  up(THICKNESS) cylinder(d=INNER_DIAMETER, h=HEIGHT);
  down(THICKNESS) cylinder(d=HOLE_DIAMETER, h=INF);
}
