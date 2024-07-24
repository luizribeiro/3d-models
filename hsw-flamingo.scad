include <lib/hsw.scad>

// holds nooelec devices like flamingo, lona, ham it up, etc

difference() {
  box_container(inner_width = 31, inner_height = 12, inner_depth = 18.8, thickness = 2, corner_radius = 2)
    position(BACK) orient(BACK) hsw_plug();
  cuboid([31-7.4*2, 18.8-2.3*2, INF], rounding=5, anchor=CENTER);
}
