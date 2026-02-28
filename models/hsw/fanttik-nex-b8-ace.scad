include <../../lib/hsw.scad>

// holds a fanttik nex b8 ace duster

difference() {
  cuboid([44 + 5, 36 + 5, HSW_PLUG_HEIGHT], rounding=17, edges="Z", anchor=CENTER) position(BACK) orient(BACK) hsw_plug();
  cuboid([44, 36, INF], rounding=15, edges="Z", anchor=CENTER);
  // for the button to slide through
  cuboid([46, 13, INF], rounding=2, edges="Z", anchor=CENTER);
}
