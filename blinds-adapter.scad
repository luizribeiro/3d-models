// this is based on thehookup's Motorized MQTT Blinds project:
// https://github.com/thehookup/Motorized_MQTT_Blinds/

$fn = 144;

difference() {
  cylinder(18, 7, 7);

  // blinds shaft
  translate([-11/2, -4.5/2, 13])
    cube([11, 4.5, 5]);

  // motor shaft
  translate([-6/2, -3.5/2, 0])
    cube([6, 3.0, 7]);
}
