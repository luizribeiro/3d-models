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
