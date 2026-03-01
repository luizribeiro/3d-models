// Model purpose: Small stopper/retainer part for a CPU holder assembly, intended to prevent movement or disengagement by adding a shaped mechanical catch.
// This is a replacement/iteration-style utility part designed around an existing holder geometry rather than a standalone product.
$fn = 100;

union() {
  /* base */
  linear_extrude(height=3.5) union() {
    circle(6.5);
    translate([20, 0]) circle(3.5);
    polygon([
      [5.04, 4.1],
      [5.04, -4.1],
      [20, -3.5],
      [20, 3.5],
    ]);
  }

  /* stick */
  translate([0, 0, 3.5]) cylinder(h=14, d=4.6);

  /* small stick? */
  translate([-2.9 - 4.6/2, -2.3/2, 6.9]) {
    union() {
      translate([2.3/2, 0, 0]) cube([2.9 + 4.6/2, 2.3, 6.4]);
      translate([2.3/2, 2.3/2, 0]) cylinder(h=6.4, d=2.3);
    }
  }

  /* small circle bump */
  translate([20, 0, 3.5 - (2.3/2 - 1)]) sphere(d=2.3);
}
