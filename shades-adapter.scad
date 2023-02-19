$fn = 250;

CYLINDER_HEIGHT = 15;
OUTER_DIAMETER = 35;
INNER_CYLINDER_DIAMETER = 23.66;
NOTCHES_INNER_CYLINDER_DIAMETER = 29.7;
SHAFT_HOLE_DIAMETER = 6.3;
SHAFT_HOLE_WIDTH = 4.5;

module cyl(h = CYLINDER_HEIGHT)
{
    difference()
    {
        cylinder(r = OUTER_DIAMETER / 2, h = h, center = true);
        translate([ 0, 0, h / 4 ]) cylinder(r = INNER_CYLINDER_DIAMETER / 2, h = h / 2 + 0.1, center = true);
    }
}

module shaft_hole()
{
    intersection()
    {
        cylinder(r = SHAFT_HOLE_DIAMETER / 2, h = 100, center = true);
        cube([ SHAFT_HOLE_WIDTH, 100, 100 ], center = true);
    }
}

module notch(a, d = 36, h = 16)
{
    difference()
    {
        cylinder(r = d / 2, h = h, center = true);
        translate([ 0, -d / 2, -h - 0.1 ]) cube([ d, d, d ]);
        rotate(a = 180 - a) translate([ 0, -d / 2, -h - 0.1 ]) cube([ d, d, d ]);
    }
}

module notch_group()
{
    rotate(a = 35/2) notch(a = 35);
    rotate(a = 90 - 18.91 / 2) notch(a = 5.24);
    rotate(a = 90 + 18.91 / 2 + 5.24 / 2) notch(a = 5.24);
}

module notches()
{
    difference()
    {
        union()
        {
            notch_group();
            rotate(a = 180) notch_group();
            rotate(a = 141) notch(a = 21.74);
        }
        cylinder(r = NOTCHES_INNER_CYLINDER_DIAMETER / 2 + 0.1, h = 100, center = true);
    }
}

difference()
{
    cyl();
    shaft_hole();
    notches();
}
