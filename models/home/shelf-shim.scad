// Model purpose: Trapezoidal shelf shim for compensating uneven gaps and stabilizing shelf or furniture contact points in the office/home.
// Includes an internal clearance cutout so the shim seats around existing features while still providing load-bearing support.
INF = 1000;
EPS = 0.01;
BOTTOM_WIDTH = 20;
TOP_WIDTH = 16;
THICKNESS = 9;
DEPTH = 20;

HOLE_WIDTH = 12.1;
HOLE_HEIGHT = 12.1;
HEIGHT = HOLE_HEIGHT + THICKNESS;

difference() {
  linear_extrude(DEPTH) polygon([
    [-BOTTOM_WIDTH/2, 0],
    [BOTTOM_WIDTH/2, 0],
    [TOP_WIDTH/2, HEIGHT],
    [-TOP_WIDTH/2, HEIGHT],
  ]);

  translate([-HOLE_WIDTH/2, HEIGHT-HOLE_HEIGHT+EPS, -INF/2])
    cube([HOLE_WIDTH, HOLE_HEIGHT, INF]);
}
