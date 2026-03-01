$fn = 100;
eps = 1e-2;

module tube_socket(
  socket_height,
  socket_diameter,
  center_pin_diameter,
  pin_diameter,
  pin_circle_diameter,
) {
  difference() {
    cylinder(socket_height, d=socket_diameter);

    translate([0, 0, -eps]) {
      cylinder(socket_height + eps * 2, d=center_pin_diameter);
      for (i = [0 : 11]) {
        translate([
          pin_circle_diameter * cos(360*i/13) / 2,
          pin_circle_diameter * sin(360*i/13) / 2,
          0,
        ]) cylinder(socket_height + eps * 2, d=pin_diameter);
      }
    }
  }
}

tube_socket(
  socket_height = 6,
  socket_diameter = 24,
  center_pin_diameter = 4.5,
  pin_diameter = 1.8,
  pin_circle_diameter = 19.5
);
translate([0, 0, 6])
  tube_socket(
    socket_height = 2,
    socket_diameter = 24,
    center_pin_diameter = 4.5,
    pin_diameter = 1.0,
    pin_circle_diameter = 19.5
  );
