// Model purpose: HSW holder for the Fanttik NEX B8 ACE tool, using a rounded profile cradle and HSW plug interface for secure wall storage.
// Optimized for quick access and consistent placement of the tool in your bench organization layout.
include <lib/hsw.scad>

// holds a fanttik nex b8 ace duster

difference() {
  cuboid([44 + 5, 36 + 5, HSW_PLUG_HEIGHT], rounding=17, edges="Z", anchor=CENTER) position(BACK) orient(BACK) hsw_plug();
  cuboid([44, 36, INF], rounding=15, edges="Z", anchor=CENTER);
  // for the button to slide through
  cuboid([46, 13, INF], rounding=2, edges="Z", anchor=CENTER);
}
