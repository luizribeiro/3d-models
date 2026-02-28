include <../../lib/hsw.scad>

// holds three fanttik nex b8 ace duster tips

box_container_with_bins(
  num_bins = 3,
  bin_width = 12,
  inner_height = 25,
  inner_depth = 12,
  thickness = 2,
  corner_radius = 2,
  separator_width = 2
) {
  position(BACK) orient(BACK) hsw_plug();
}
