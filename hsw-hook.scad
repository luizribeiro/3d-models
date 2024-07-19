include <lib/base.scad>
include <lib/hsw.scad>

$fn=100;

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
