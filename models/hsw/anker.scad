// Model purpose: HSW wall holder for an Anker-branded accessory/device, sized as a dedicated cradle for repeatable storage in the electronics area.
// Keeps the item stable and easy to grab while preserving compatibility with the standard HSW mounting pattern.
include <lib/hsw.scad>

// holds an anker 511 charger (nano pro)

difference() {
  hsw_box(
    inner_width = 28,
    inner_depth = 28,
    inner_height = 10,
    thickness = 2
  );

  cuboid([16, 16, INF], rounding=2);
}
