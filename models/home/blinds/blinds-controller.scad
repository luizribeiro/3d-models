// Model purpose: Controller enclosure/base for the motorized blinds PCB, including standoffs, nut traps, and perimeter walls for secure board mounting.
// Designed to protect electronics and keep screw alignment consistent while fitting the specific board size used in your blinds project.
pcb_width = 70;
pcb_height = 50;
case_thickness = 3;
standoff_height = 3;
edge_height = 2.5;

pcb_hole_diameter = 2;
screw_hole_diameter = 2.2;
hole_dist_from_edge = 0.75 + pcb_hole_diameter/2;
standoff_diameter = 4;
hex_nut_diameter = 4.33;

$fn = 100;

render();

module standoff() {
  difference() {
    cylinder(d=standoff_diameter, h=standoff_height);
    cylinder(d=screw_hole_diameter, h=standoff_height);
  }
}

module nut_hole() {
  union() {
    cylinder($fn=6, r=hex_nut_diameter/sqrt(3), h=2);
    cylinder(d=screw_hole_diameter, h=case_thickness);
  }
}

module controller() {
  union() {
    difference() {
      cube([
        pcb_width + case_thickness * 2,
        pcb_height + case_thickness * 2,
        case_thickness + standoff_height + edge_height,
      ]);
      translate([case_thickness, case_thickness, case_thickness])
        cube([
          pcb_width,
          pcb_height,
          standoff_height + edge_height,
        ]);
      translate([case_thickness - 1, case_thickness - 1, case_thickness])
        cube([
          pcb_width + 2,
          pcb_height + 2,
          standoff_height + edge_height,
        ]);

      /* nut holes */
      translate([case_thickness, case_thickness, 0]) {
        translate([hole_dist_from_edge, hole_dist_from_edge, 0])
          nut_hole();
        translate([pcb_width - hole_dist_from_edge, hole_dist_from_edge, 0])
          nut_hole();
        translate([
          pcb_width - hole_dist_from_edge,
          pcb_height - hole_dist_from_edge,
          0,
        ]) nut_hole();
        translate([hole_dist_from_edge, pcb_height - hole_dist_from_edge, 0])
          nut_hole();
      }
    }

    /* standoffs */
    translate([case_thickness, case_thickness, case_thickness]) {
      translate([hole_dist_from_edge, hole_dist_from_edge, 0]) standoff();
      translate([pcb_width - hole_dist_from_edge, hole_dist_from_edge, 0])
        standoff();
      translate([
        pcb_width - hole_dist_from_edge,
        pcb_height - hole_dist_from_edge,
        0,
      ]) standoff();
      translate([hole_dist_from_edge, pcb_height - hole_dist_from_edge, 0])
        standoff();
    }
  }
}

controller();
