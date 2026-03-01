// Model purpose: HSW holder for Staedtler stationery tool(s), designed as a simple wall-mounted organizer for frequent marking/measuring tasks.
// Integrates with the same modular storage wall to keep non-electronic bench tools equally organized.
include <lib/hsw.scad>

// holds a staedtler pencil sharpener

INNER_HEIGHT = 15;
THICKNESS = 5;
INNER_DIAMETER = 42.5;

difference() {
  cylinder(d=INNER_DIAMETER+THICKNESS, h=INNER_HEIGHT+THICKNESS) {
    up(HSW_PLUG_HEIGHT/2) position(BACK + BOTTOM) orient(BACK) down(10) hsw_plug(length=20);
  }
  up(THICKNESS) cylinder(d=INNER_DIAMETER, h=INF);
}
