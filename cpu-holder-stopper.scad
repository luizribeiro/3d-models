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
  translate([-2.9 - 4.6/2, -2.3/2, 5.9]) cube([2.9 + 4.6/2, 2.3, 7.4]);

  /* small circle bump */
  translate([20, 0, 3.5 - (2.3/2 - 1)]) sphere(d=2.3);
}
