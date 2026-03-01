// Model purpose: HSW holder for an RTL-SDR dongle, providing a small protective parking spot on the honeycomb storage wall.
// Keeps SDR adapters centralized with related RF tools for faster experiment setup.
include <lib/hsw.scad>

// holds rtl-sdr blog v3 dongle

difference() {
  box_container(inner_width = 27.5, inner_height = 25, inner_depth = 13.6, thickness = 2, corner_radius = 2)
    position(BACK) orient(BACK) hsw_plug();
  cuboid([12.5, 12.5, INF], rounding=5, anchor=CENTER);
}
