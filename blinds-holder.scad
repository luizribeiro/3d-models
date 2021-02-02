use <blinds-controller.scad>;
use <blinds-large-bar.scad>;
use <blinds-motor-case.scad>;

pcb_width = 70;
pcb_height = 50;
edge_height = 2.5;
case_thickness = 3;
standoff_height = 3;

screw_bar_width = 10;
screw_bar_height = 120;
screw_bar_depth = 5;

module filled_large_bar() {
  union() {
    translate([0, 0, screw_bar_height - pcb_width - case_thickness * 2])
      cube([screw_bar_depth, screw_bar_width, pcb_width + case_thickness * 2]);
    large_bar();
  }
}

union() {
  controller();

  translate([
    screw_bar_height,
    -screw_bar_depth,
    standoff_height + case_thickness + edge_height,
  ])
    rotate([0, -90, 0])
    rotate([0, 0, 90])
    filled_large_bar();

  translate([
    screw_bar_height,
    pcb_height + case_thickness * 2,
    standoff_height + case_thickness + edge_height,
  ])
    rotate([0, -90, 0])
    rotate([0, 0, 90])
    filled_large_bar();

  // uncomment this if you want to see the motor in place
  /*
  translate([screw_bar_height * 7 / 8, pcb_height / 2 + case_thickness, 0])
    rotate([0, -90, 0])
    motor_case();
  */
}
