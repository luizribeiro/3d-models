include <../../lib/hsw.scad>

// holds a bambulab glue stick

HEIGHT = 42;
THICKNESS = 5;
INNER_DIAMETER = 25.5;

difference() {
  cylinder(d=INNER_DIAMETER+THICKNESS, h=HEIGHT) {
    position(BACK) orient(BACK) down(10) hsw_plug(length=20);
  }
  up(THICKNESS) cylinder(d=INNER_DIAMETER, h=HEIGHT);
}
