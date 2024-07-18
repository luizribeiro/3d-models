INF = 1000;
SCALE = 1.1;
render() difference() {
  import("dependencies/Celestron 925 Mounting Bracket.stl");
  translate([0, 5.5, -INF/2]) linear_extrude(height=INF) polygon([
    [-12.210986159 * SCALE, 5.5],
    [-16.5 * SCALE, -5.5],
    [16.5 * SCALE, -5.5],
    [12.210986159 * SCALE, 5.5],
  ]);
}
