// this is based on thehookup's Motorized MQTT Blinds project:
// https://github.com/thehookup/Motorized_MQTT_Blinds/blob/master/BlindsBase.scad

block_z = 22;
block_y = 55;
block_x = 37;
cylinder_cutout_depth = 25;

difference() {
  cube([block_x, block_y, block_z], center=true);
  
  translate([0, 2.4, 0]) {
    color("blue")
      translate([0,0,3])
      cylinder(r=14.1, h=cylinder_cutout_depth, $fn=100, center=true);
    color("red") translate([5.7,0,6]) cube([17,18,30.5], center=true);
    color("black") translate([10,0,6]) cube([17,15,30.5], center=true);
    
    color("purple") translate([0,17.4,10]) cylinder(r=3.35, h=2, $fn=100);
    color("orange") translate([0,14.05,11]) cube([6.7,6.7,2], center=true);
    
    color("purple") translate([0,-17.4,10]) cylinder(r=3.35, h=2, $fn=100);
    color("orange") translate([0,-14.05,11]) cube([6.7,6.7,2], center=true);

    color("green") translate([0,-17.4,6]) cylinder(r=1.5, h=5, $fn=100);
    color("green") translate([0,17.4,6]) cylinder(r=1.5, h=5, $fn=100);

    color("cyan")
      translate([(block_x / 2),0,-(block_z/2)])
      cylinder(r=2, h=4, $fn=100, center=true);
  }

  // Cut out notches on corners for blind lip.
  color("magenta")
    translate([-((block_x - 2.5)/2), ((block_y - 2.5)/2), 0])
    cylinder(r=3, h=block_z, center=true, $fn=100);
  color("magenta")
    translate([-((block_x - 2.5)/2), -((block_y - 2.5)/2), 0])
    cylinder(r=3, h=block_z, center=true, $fn=100);
}
