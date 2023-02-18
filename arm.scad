difference() {
  union() {
    translate([-60-90, 0, 0])
      import("dependencies/arm.stl", convexity=3);

    difference() {
      translate([-60-90, 0, -1.8])
        import("dependencies/arm.stl", convexity=3);
      translate([-6.2, -20.4, -5.4-1.8])
        cube([6, 5, 10]);
    }

    translate([-0.1, -23.4, -5.4-2.22])
      cube([2.5, 10, 10]);
  }

  translate([-6.2, -20.4, -5.4])
    cube([6, 5, 10]);
  translate([-2.1, -23.4, -5.4])
    cube([2, 13, 10]);
}
