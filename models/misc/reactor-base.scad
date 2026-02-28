$fn = 128;

in = 25.4;
height = 1*in;
eps = 0.1*in;
text_depth = 0.2*in;

difference() {
  cube([3*in, 3*in, height]);

  translate([0, 0, height - 0.12*in]) {
    translate([0.25*in, 0.25*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([1.5*in, 0.25*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([3*in - 0.25*in, 0.25*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([3*in - 0.25*in, 1.5*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([3*in - 0.25*in, 3*in - 0.25*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([1.5*in, 3*in - 0.25*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([0.25*in, 3*in - 0.25*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
    translate([0.25*in, 1.5*in, 0]) cylinder(h=0.12*in+eps, d=0.42*in);
  }

  translate([0, 0, -eps/2]) {
    translate([1.1*in, 1.1*in, 0]) cylinder(h=height+eps, d=0.7*in);
    translate([(3-0.5)*in, 0.85*in, 0]) cylinder(h=height+eps, d=0.7*in);
    translate([0.5*in, (3-0.85)*in, 0]) cylinder(h=height+eps, d=0.7*in);
    translate([(3-1.1)*in, (3-1.1)*in, 0]) cylinder(h=height+eps, d=0.7*in);
  }

  translate([3*in - text_depth + eps, 3*in/2, height/2])
    rotate([90, 0, 90])
    linear_extrude(text_depth) text("RenewCO2", valign="center", halign="center");
}
