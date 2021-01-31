screw_bar_depth = 5;
screw_bar_width = 10;
screw_bar_height = 120;

blind_depth = 6.5;
blind_gap = 3.5;
blind_hook_height = 10;

screw_bar_margin = 3.5;

module large_bar() {
  union() {
    difference() {
      cube([screw_bar_depth, screw_bar_width, screw_bar_height]);
      translate([0, screw_bar_margin, screw_bar_margin])
        cube([
          screw_bar_depth,
          screw_bar_width - screw_bar_margin * 2,
          screw_bar_height - screw_bar_margin * 2,
        ]);
    }

    translate([0, 0, screw_bar_height/4])
      cube([screw_bar_depth, screw_bar_width, 5]);

    translate([0, 0, 2*screw_bar_height/4])
      cube([screw_bar_depth, screw_bar_width, 5]);

    translate([0, 0, 3*screw_bar_height/4])
      cube([screw_bar_depth, screw_bar_width, 5]);

    translate([0, screw_bar_width, screw_bar_height - blind_gap])
      cube([screw_bar_depth, blind_depth, blind_gap]);

    translate([
      0,
      screw_bar_width + blind_depth,
      screw_bar_height - blind_gap - blind_hook_height
    ])
      cube([screw_bar_depth, blind_gap, blind_gap + blind_hook_height]);
  }
}

large_bar();
