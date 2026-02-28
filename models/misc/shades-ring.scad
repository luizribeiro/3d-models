$fn = 250;
eps = 0.1;

CYLINDER_HEIGHT = 15;
OUTER_DIAMETER = 35;
INNER_CYLINDER_DIAMETER = 25.4;
TIGHTER_INNER_CYLINDER_DIAMETER = 24.0;
TIGHTER_INNER_CYLINDER_HEIGHT = 7.4;
NOTCHES_INNER_CYLINDER_DIAMETER = 29.7;

OPENING_SIZE = 0.5;

BIG_NOTCH_ANGLE = 35;
MID_NOTCH_ANGLE = 21.74;
SMALL_NOTCH_ANGLE = 6;
NOTCH_ANGLE_DISTANCE = 18.91;

module cyl(h = CYLINDER_HEIGHT)
{
    difference()
    {
        cylinder(r = OUTER_DIAMETER / 2, h = h, center = true);
        cylinder(r = TIGHTER_INNER_CYLINDER_DIAMETER / 2, h = h + eps, center = true);
        translate([0, 0, h/2 - (h - TIGHTER_INNER_CYLINDER_HEIGHT)/2])
          cylinder(
            r = INNER_CYLINDER_DIAMETER / 2,
            h = (h - TIGHTER_INNER_CYLINDER_HEIGHT) + eps,
            center = true
          );
        translate([0, OUTER_DIAMETER/2, 0])
          cube([OPENING_SIZE, OUTER_DIAMETER + eps, h + eps], center = true);
    }
}

module notch(a, d = 36, h = 16)
{
    difference()
    {
        cylinder(r = d / 2, h = h, center = true);
        translate([ 0, -d / 2, -h - eps ]) cube([ d, d, d ]);
        rotate(a = 180 - a) translate([ 0, -d / 2, -h - eps ]) cube([ d, d, d ]);
    }
}

module notch_group()
{
    rotate(a = BIG_NOTCH_ANGLE / 2) notch(a = BIG_NOTCH_ANGLE);
    rotate(a = 90 - NOTCH_ANGLE_DISTANCE / 2) notch(a = SMALL_NOTCH_ANGLE);
    rotate(a = 90 + SMALL_NOTCH_ANGLE + NOTCH_ANGLE_DISTANCE / 2) notch(a = SMALL_NOTCH_ANGLE);
}

module notches()
{
    difference()
    {
        union()
        {
            notch_group();
            rotate(a = 180) notch_group();
            rotate(a = 142) notch(a = MID_NOTCH_ANGLE);
        }
        cylinder(r = NOTCHES_INNER_CYLINDER_DIAMETER / 2 + eps, h = 100, center = true);
    }
}

difference()
{
    cyl();
    notches();
}
