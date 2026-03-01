// Model purpose: Printable door stop intended to hold a door open and prevent impacts against walls or furniture in a household/office setting.
// Geometry combines a stable base with screw holes and angled contact surfaces for secure placement and repeated daily use.
difference() {
  union() {
    cube([3, 40, 100]);
    difference() {
    translate([10, 0, 0])
      cylinder(100, 20, 20, $fn=3);
      translate([-0.1, 0, -0.1]) cube([100, 100, 110]);
    }
  }
  translate([-0.1, 7, 7]) rotate([0, 90, 0]) cylinder(5, 3, 5);
  translate([-0.1, 7, 50]) rotate([0, 90, 0]) cylinder(5, 3, 5);
  translate([-0.1, 7, 93]) rotate([0, 90, 0]) cylinder(5, 3, 5);

  translate([-0.1, 33, 7]) rotate([0, 90, 0]) cylinder(5, 3, 5);
  translate([-0.1, 33, 50]) rotate([0, 90, 0]) cylinder(5, 3, 5);
  translate([-0.1, 33, 93]) rotate([0, 90, 0]) cylinder(5, 3, 5);

  translate([28, -11, -1]) cube([3, 42, 102]);
}
