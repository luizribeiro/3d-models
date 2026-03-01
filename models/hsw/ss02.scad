// Model purpose: HSW holder for the Engineer SS-02 solder sucker, shaped to secure the tool and keep it accessible during solder rework.
// Balances retention and clearance so the desoldering pump can be removed quickly with one hand.
include <lib/hsw.scad>

// holds a engineer ss-02 solder sucker

difference() {
  cylinder(d=20, h=13.3) {
    position(BACK) orient(BACK) down(10) hsw_plug(length=20);
  }
  down(EPS) cylinder(d=5, h=14);
  fwd(5) cube([5, 10, INF], anchor=CENTER);
}
