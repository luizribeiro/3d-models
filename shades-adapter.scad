$fn = 250;

module cyl()
{
    difference()
    {
        cylinder(r = 2, h = 1, center = true);
        translate([ 0, 0, 0.5 ]) cylinder(r = 1.5, h = 1, center = true);
    }
}

module shaft_hole()
{
    intersection()
    {
        cylinder(r = 0.5, h = 10, center = true);
        cube([ 0.5, 2, 2 ], center = true);
    }
}

module notch(a)
{
    difference()
    {
        cylinder(r = 2.25, h = 5, center = true);
        translate([ 0, -3.5, -3.5 ]) cube([ 10, 10, 10 ]);
        rotate(a = 180 - a) translate([ 0, -3.5, -3.5 ]) cube([ 10, 10, 10 ]);
    }
}

module notches()
{
    difference()
    {
        union()
        {
            notch(a = 45);
            rotate(a = 90) notch(a = 45);
            rotate(a = 180) notch(a = 45);
            rotate(a = 270) notch(a = 45);
        }
        cylinder(r = 1.75, h = 10, center = true);
    }
}

difference()
{
    cyl();
    shaft_hole();
    notches();
}
