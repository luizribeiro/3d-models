$fn = 250;
epsilon = 0.01;
PLATE_DIAMETER = 42.7;
PLATE_WIDTH = 2.0;
SCREW_HOLE_DIAMETER_TOP = 4.97;
SCREW_HOLE_DIAMETER_BOTTOM = 3.01;
SCREW_HOLE_DISTANCE = 1.65;

HOOK_HEIGHT = 4.4;
HOOK_WIDTH = 4.1;
HOOK_LENGTH = 11.8;
HOOKS_DISTANCE = 19.3;
HOOK_GAP = 2.12;

module screw_hole()
{
    translate([ 0, PLATE_DIAMETER / 2 - SCREW_HOLE_DISTANCE - SCREW_HOLE_DIAMETER_BOTTOM / 2, 0 ])
        cylinder(r1 = SCREW_HOLE_DIAMETER_BOTTOM / 2, r2 = SCREW_HOLE_DIAMETER_TOP / 2, h = PLATE_WIDTH + epsilon,
                 center = true);
}

module hook()
{
    difference()
    {
        cube([ HOOK_WIDTH, HOOK_LENGTH, HOOK_HEIGHT ], center = true);
        translate([ 0, -HOOK_LENGTH / 2 + HOOK_GAP / 2, -HOOK_HEIGHT / 2 + HOOK_GAP / 2 ])
            cube([ HOOK_WIDTH + epsilon, HOOK_GAP + epsilon, HOOK_GAP + epsilon ], center = true);
    }
}

difference()
{
    cylinder(r = PLATE_DIAMETER / 2, h = PLATE_WIDTH, center = true);
    rotate(a = 0) screw_hole();
    rotate(a = 120) screw_hole();
    rotate(a = 240) screw_hole();
}

translate([ 0, -HOOK_GAP, 0 ])
{
    translate([ HOOKS_DISTANCE / 2 - HOOK_WIDTH / 2, 0, PLATE_WIDTH / 2 + HOOK_HEIGHT / 2 ]) hook();
    translate([ -HOOKS_DISTANCE / 2 + HOOK_WIDTH / 2, 0, PLATE_WIDTH / 2 + HOOK_HEIGHT / 2 ]) hook();
}
