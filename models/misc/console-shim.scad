include <../../lib/base.scad>
include <../../lib/BOSL2/std.scad>
include <../../lib/BOSL2/rounding.scad>

WIDTH = 22.5;
HEIGHT = 45;
DEPTH = 16;
SHIM_THICKNESS = 9;
BORDER_THICKNESS = 2;

difference() {
  cuboid([WIDTH + BORDER_THICKNESS, HEIGHT + BORDER_THICKNESS, DEPTH], rounding=2, edges="Z", anchor=BOTTOM);
  up(SHIM_THICKNESS) cuboid([WIDTH, HEIGHT, DEPTH], rounding=2, edges="Z", anchor=BOTTOM);
}
