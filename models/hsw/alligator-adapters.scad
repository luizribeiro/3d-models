// Model purpose: HSW-compatible holder for alligator clip adapters, keeping clips organized and accessible on the honeycomb storage wall.
// Part geometry is tuned to grip the adapters while mounting via standard HSW plug features.
include <lib/hsw.scad>

// holds two alligator adapters for multimeter probes (fluke?)

box_container_with_bins(
  num_bins = 2,
  bin_width = 16,
  inner_height = 35,
  inner_depth = 16,
  thickness = 2,
  corner_radius = 2,
  separator_width = 2
) {
  position(BACK) orient(BACK) hsw_plug();
}
