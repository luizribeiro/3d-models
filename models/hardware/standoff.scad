// Model purpose: General-purpose printable standoff with screw through-hole and captive hex-nut pocket for mounting boards or panels with fixed spacing.
// Useful when you need quick custom-height supports without metal spacers, especially for one-off fixtures and electronics prototypes.
$fn = 100;
INF = 10000;
EPS = 0.01;

STANDOFF_DIAMETER = 7.5;
STANDOFF_HEIGHT = 18;
NUT_DIAMETER = 5.7;
NUT_HEIGHT = 14;
SCREW_DIAMETER = 2.7;

module standoff() {
  difference() {
    cylinder(h=STANDOFF_HEIGHT, d=STANDOFF_DIAMETER);
    translate([0, 0, -EPS]) cylinder(h=NUT_HEIGHT, d=NUT_DIAMETER, $fn=6);
    cylinder(h=INF, d=SCREW_DIAMETER);
  }
}

standoff();
