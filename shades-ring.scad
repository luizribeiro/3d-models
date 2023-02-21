$fn = 250;
eps = 0.1;

CYLINDER_HEIGHT = 15;
OUTER_DIAMETER = 35;
INNER_CYLINDER_DIAMETER = 26.6;
NOTCHES_INNER_CYLINDER_DIAMETER = 29.7;

BIG_NOTCH_ANGLE = 35;
MID_NOTCH_ANGLE = 21.74;
SMALL_NOTCH_ANGLE = 6;
NOTCH_ANGLE_DISTANCE = 18.91;

INNER_NOTCH_HEIGHT = 2;
INNER_NOTCH_WIDTH = 4;

module cyl(h = CYLINDER_HEIGHT)
{
    difference()
    {
        cylinder(r = OUTER_DIAMETER / 2, h = h, center = true);
        cylinder(r = INNER_CYLINDER_DIAMETER / 2, h = h + eps, center = true);
        rotate(a = -45) translate([ INNER_NOTCH_HEIGHT / 3 + INNER_CYLINDER_DIAMETER / 2, 0, 0 ])
            cube([ INNER_NOTCH_HEIGHT, INNER_NOTCH_WIDTH, h + eps ], center = true);
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
