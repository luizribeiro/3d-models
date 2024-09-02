include <lib/hsw.scad>

// holds an upside down gorilla super glue gel xl

HEIGHT = 42;
THICKNESS = 5;
INNER_DIAMETER = 21;

difference() {
  cylinder(d=INNER_DIAMETER+THICKNESS, h=HEIGHT) {
    position(BACK) orient(BACK) down(10) hsw_plug(length=20);
  }
  up(THICKNESS) cylinder(d=INNER_DIAMETER, h=HEIGHT);
  down(THICKNESS) cylinder(d=10.5, h=INF);
}
