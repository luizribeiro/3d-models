include <lib/hsw.scad>

// holds a 38mm meds canister

INNER_HEIGHT = 15;
THICKNESS = 5;
INNER_DIAMETER = 39;

difference() {
  cylinder(d=INNER_DIAMETER+THICKNESS, h=INNER_HEIGHT+THICKNESS) {
    up(HSW_PLUG_HEIGHT/2) position(BACK + BOTTOM) orient(BACK) down(10) hsw_plug(length=20);
  }
  up(THICKNESS) cylinder(d=INNER_DIAMETER, h=INF);
}
