width = 50; // mm
depth = 10; // mm
step_height = 1; // mm
step_width = 5; // mm
rounded_corner_radius = 1; // mm

translate([rounded_corner_radius, rounded_corner_radius, 0])
union() {
  for (i = [0 : 1 : width / step_width]) {
    translate([0, 0, step_height*i])
    minkowski() {
      cube([width - i * step_width, depth, step_height]);
      cylinder(r=rounded_corner_radius, h=step_height, $fn=100);
    }
  }
}
