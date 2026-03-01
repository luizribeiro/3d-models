// Model purpose: General-purpose HSW hook for hanging lightweight tools, cables, or accessories that do not require a custom-form holder.
// Useful as a flexible catch-all mount point within the same honeycomb storage wall system.
include <lib/hsw.scad>

hsw_hook(
  path=[
    [0, 0],
    [0, 4],
    [0, 5],
    [-3, 10],
    [0, 15],
  ],
  radius=2.5
);
