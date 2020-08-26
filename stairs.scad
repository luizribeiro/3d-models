module calibration_stairs(
  width = 50, // mm
  depth = 10, // mm
  step_height = 1, // mm
  step_width = 5, // mm
  rounded_corner_radius = 0, // mm
  base_height = 10, // mm
) {
  difference() {
    translate([rounded_corner_radius, rounded_corner_radius, 0])
    union() {
      cube([width, depth, base_height]);

      for (i = [0 : 1 : width / step_width]) {
        translate([0, 0, base_height + step_height*i])
        minkowski() {
          cube([width - i * step_width, depth, step_height]);
          cylinder(r=rounded_corner_radius, h=step_height, $fn=100);
        }
      }

      translate([-0.5, -0.5, base_height - 0.5])
        cube([width + 0.5 * 2, depth + 0.5 * 2, 0.5]);
    }

    translate([2, 0, 2])
      rotate(a=[90, 0, 0])
      text(str(step_height, "mm steps"), size=5);
  }
}

translate([0, 0, 0]) calibration_stairs(step_height=0.05);
translate([0, 20, 0]) calibration_stairs(step_height=0.1);
translate([0, 40, 0]) calibration_stairs(step_height=0.2);
translate([0, 60, 0]) calibration_stairs(step_height=0.5);
translate([0, 80, 0]) calibration_stairs(step_height=1.0);
translate([0, 100, 0]) calibration_stairs(step_height=2.0);
translate([0, 120, 0]) calibration_stairs(step_height=3.0);
translate([0, 140, 0]) calibration_stairs(step_height=5.0);
