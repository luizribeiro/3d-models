// Model purpose: Companion small bar/connector piece for the motorized blinds frame, used as a linking or clamping element between larger structural parts.
// Provides simple printable geometry for quick iteration of fit and fastening in the overall blinds mount stack.
block_z = 22;
block_y = 42;
block_x = 30;
connector_gap = 0.5;

$fn = 100;

difference() {
  translate([-block_x/2 - connector_gap/2, -block_y/2 - 10, -block_z/2]) {
    difference() {
      cube([block_x + connector_gap, 5, block_z]);
      translate([block_x, 0, block_z/2])
      cube([block_x*2, block_y, 3], center=true);
    }
    translate([-5, 0, 0])
      cube([5, block_y/3 + block_y/5, block_z]);
    translate([block_x + connector_gap, 0, 0])
      cube([5, block_y/3 + block_y/5, block_z]);
  }

  translate([-block_x/2 - 50, -block_y/3, 0])
    rotate([0, 90, 0])
    cylinder(r=4/2, h=100);
}
