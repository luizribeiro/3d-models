// Model purpose: Reshapes an existing Celestron C9.25 mounting bracket STL by trimming a clearance wedge so the bracket fits the intended telescope setup and mechanical constraints.
// This model imports the original vendor/community STL and performs a subtractive cut, keeping the original geometry while adapting fit for your rig.
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
