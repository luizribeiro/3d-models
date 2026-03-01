// Model purpose: HSW holder for the CurrentWave-DP device (Dothediy), dimensioned to mount the unit neatly on the honeycomb storage wall.
// Designed for convenient access while keeping the device protected and consistently located in the SDR/electronics workspace.
include <lib/hsw.scad>

// holds a DoTheDiy's CurrentWave

difference() {
  box_container(
    inner_depth = 30.5,
    inner_width = 54.5,
    inner_height = 30,
    thickness = 2,
    corner_radius = 2
  ) {
    position(BACK) orient(BACK) hsw_horizontal_plugs(2);
  }
  up(10) cuboid([47, INF, 60], rounding=2, anchor=BOTTOM + BACK);
}
