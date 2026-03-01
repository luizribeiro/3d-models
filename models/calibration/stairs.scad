module calibration_stairs(
  width = 50, // mm
  depth = 10, // mm
  step_height = 1, // mm
  step_width = 5, // mm
  base_height = 10, // mm
) {
  $fn = 100;

  difference() {
    union() {
      cube([width, depth, base_height]);

      for (i = [1 : 1 : width / step_width]) {
        translate([0, 0, base_height + step_height * (i - 1)])
          cube([width - (i - 1) * step_width, depth, step_height]);
      }

      translate([-0.5, -0.5, base_height - 0.5])
        cube([width + 0.5 * 2, depth + 0.5 * 2, 0.5]);
    }

    for (i = [1 : 1 : width / step_width]) {
      translate([
        width - i * step_width + step_width / 2 + 0.5,
        0.5,
        base_height + step_height * i - 0.5,
      ])
        rotate(a=[0, 0, 90])
        linear_extrude(height=2)
        text(str(step_height * i + base_height, "mm"), size=1.5);
    }
  }
}

step_height_arg = is_undef(step_height) ? 1.0 : step_height;
calibration_stairs(step_height=step_height_arg);
