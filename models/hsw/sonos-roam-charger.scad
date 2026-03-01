// Model purpose: HSW holder for a Sonos Roam charger accessory, creating a tidy wall-mounted dock/storage point.
// Keeps charging hardware organized and reduces cable clutter in mixed electronics/household spaces.
include <lib/hsw.scad>

module sonos() {
  scale(0.74) import(file="dependencies/sonos footprint.svg", center=true);
}

INNER_HEIGHT = 11;
THICKNESS = 5;

difference() {
  scale(1.1) fwd(1) linear_extrude(INNER_HEIGHT + THICKNESS) sonos();
  up(THICKNESS) linear_extrude(INF) sonos();
  zrot(60) up(5) right(6) fwd(40) cube([10, 30, 30], anchor=BOTTOM);
}

difference() {
  up((INNER_HEIGHT + THICKNESS)/2) fwd(10) xrot(90)
    hsw_horizontal_plugs(num_plugs=2, length=20);
  up(THICKNESS) linear_extrude(INF) sonos();
  zrot(60) up(5) right(6) fwd(40) cube([10, 30, 30], anchor=BOTTOM);
}
