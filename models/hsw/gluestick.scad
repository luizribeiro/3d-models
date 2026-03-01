// Model purpose: HSW holder for glue sticks, giving consumables a fixed wall position so they are available when doing assembly or rework.
// Sized to prevent sticks from falling out while still allowing quick one-handed retrieval.
include <lib/hsw.scad>

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
