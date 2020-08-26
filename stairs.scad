width = 50; // mm
depth = 10; // mm
step_height = 1; // mm
step_width = 5; // mm

union() {
  for (i = [0 : 1 : width / step_width]) {
    translate([0, 0, step_height*i])
    cube([width - i * step_width, depth, step_height]);
  }
}
