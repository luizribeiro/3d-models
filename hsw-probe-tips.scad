include <lib/hsw.scad>

// holds two TP88 fluke probe pins

difference() {
  cuboid([10, 30.84, 20], rounding=2, edges=[BOTTOM, FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT]) {
    position(TOP) zrot(90) back(1.6) hsw_plug();
  }
  left(INF/2) yrot(90) {
    back(8) cylinder(h=INF, d=6.3);
    fwd(8) cylinder(h=INF, d=6.3);
  }
}
