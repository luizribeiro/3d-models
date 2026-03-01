// Model purpose: HSW holder for a Pentel eraser, giving a small stationery item a dedicated slot so it does not get lost on the bench.
// Keeps drafting/marking accessories close at hand while preserving a clean workspace.
include <lib/hsw.scad>

// holds four scope probes

box_container_with_bins(
  num_bins = 2,
  bin_width = 14.5,
  inner_height = 12,
  inner_depth = 19.5,
  thickness = 3,
  corner_radius = 2,
  separator_width = 2
) {
  position(BACK) orient(BACK) hsw_plug();
}
