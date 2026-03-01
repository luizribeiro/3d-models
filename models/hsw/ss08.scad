// Model purpose: HSW holder for the Engineer SS-08 IC extractor, providing a compact dedicated mount for this specialty extraction tool.
// Helps prevent misplacement and keeps the extractor near other soldering/rework equipment.
include <lib/hsw.scad>

// holds the engineer ss-08 ic extractor

hsw_plug() {
  attach(TOP, TOP) cylinder(d=17, h=14);
}
