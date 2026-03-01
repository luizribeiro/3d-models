// Model purpose: HSW holder for the Engineer PAW-21 tool, creating a purpose-fit wall mount that secures the tool without obstructing grip areas.
// Designed for frequent use in electronics/mechanical work where fast retrieval and tidy storage matter.
include <lib/hsw.scad>

POST_DIAMETER = 13;
POST_TIP_DIAMETER = 12.5;
POST_LENGTH = 30;
ARM_DEPTH = 22;

cuboid([POST_DIAMETER, ARM_DEPTH, POST_DIAMETER], anchor=BACK+BOTTOM) {
  position(BACK) orient(BACK) hsw_plug();
}

fwd(ARM_DEPTH) up(POST_DIAMETER)
  cylinder(d1=POST_TIP_DIAMETER, d2=POST_DIAMETER, h=POST_LENGTH + POST_DIAMETER, anchor=TOP);
