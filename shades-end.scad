$fn = 250;
epsilon = 0.01;
PLATE_DIAMETER = 42.6;
PLATE_WIDTH = 3.0;
SCREW_HOLE_DIAMETER_TOP = 4.97;
SCREW_HOLE_DIAMETER_BOTTOM = 3.01;
SCREW_HOLE_DISTANCE = 1.55;

HOOK_HEIGHT = 4.4;
HOOK_WIDTH = 4.1;
HOOK_LENGTH = 11.8;
HOOKS_DISTANCE = 19.3;
HOOK_GAP_LENGTH = 2.5;
HOOK_GAP_HEIGHT_LARGE = 2.5;
HOOK_GAP_HEIGHT_SMALL = 2;

CONNECTOR_DIAMETER = 6.25;
CONNECTOR_OUTSIDE_LENGTH = 1.0;

PLATE_GAP_WIDTH = 5.8;
PLATE_GAP_HEIGHT = 2;

module screw_hole()
{
    translate([ 0, PLATE_DIAMETER / 2 - SCREW_HOLE_DISTANCE - SCREW_HOLE_DIAMETER_BOTTOM / 2, 0 ])
        cylinder(r1 = SCREW_HOLE_DIAMETER_BOTTOM / 2, r2 = SCREW_HOLE_DIAMETER_TOP / 2, h = PLATE_WIDTH + epsilon,
                 center = true);
}

module horizontal_hook()
{
    difference()
    {
        cube([ HOOK_LENGTH, HOOK_WIDTH, HOOK_HEIGHT ], center = true);
        translate([
            -HOOK_LENGTH / 2 - epsilon / 2, -HOOK_WIDTH / 2 - epsilon,
            // FIXME: this looks wrong and breaks when we change gap heights
            -HOOK_HEIGHT / 2 -
            epsilon
        ]) rotate([ 90, 0, 0 ]) rotate([ 0, 90, 0 ]) linear_extrude(height = HOOK_LENGTH + epsilon)
            polygon(points = [
                [ 0, 0 ], [ 0, HOOK_GAP_HEIGHT_LARGE ], [ HOOK_GAP_LENGTH, HOOK_GAP_HEIGHT_SMALL ],
                [ HOOK_GAP_LENGTH, 0 ]
            ]);
    }
}

module vertical_hook()
{
    difference()
    {
        cube([ HOOK_WIDTH, HOOK_LENGTH, HOOK_HEIGHT ], center = true);
        translate([
            -HOOK_WIDTH / 2 - epsilon / 2, -HOOK_LENGTH / 2 - epsilon,
            // FIXME: this looks wrong and breaks when we change gap heights
            -HOOK_HEIGHT / 2 -
            epsilon
        ]) rotate([ 90, 0, 0 ]) rotate([ 0, 90, 0 ]) linear_extrude(height = HOOK_WIDTH + epsilon)
            polygon(points = [
                [ 0, 0 ], [ 0, HOOK_GAP_HEIGHT_LARGE ], [ HOOK_GAP_LENGTH, HOOK_GAP_HEIGHT_SMALL ],
                [ HOOK_GAP_LENGTH, 0 ]
            ]);
    }
}

difference()
{
    cylinder(r = PLATE_DIAMETER / 2, h = PLATE_WIDTH, center = true);
    rotate(a = 0) screw_hole();
    rotate(a = 120) screw_hole();
    rotate(a = 240) screw_hole();
    // gaps for led and on/off switch
    // TODO: turn this into an arc
    translate([ 0, -PLATE_DIAMETER / 2 + PLATE_GAP_HEIGHT / 2, 0 ])
        cube([ PLATE_GAP_WIDTH, PLATE_GAP_HEIGHT, PLATE_WIDTH + epsilon ], center = true);
    rotate(a = -10) translate([ 0, -PLATE_DIAMETER / 2 + PLATE_GAP_HEIGHT / 2, 0 ])
        cube([ PLATE_GAP_WIDTH, PLATE_GAP_HEIGHT, PLATE_WIDTH + epsilon ], center = true);
    rotate(a = -20) translate([ 0, -PLATE_DIAMETER / 2 + PLATE_GAP_HEIGHT / 2, 0 ])
        cube([ PLATE_GAP_WIDTH, PLATE_GAP_HEIGHT, PLATE_WIDTH + epsilon ], center = true);
    rotate(a = -30) translate([ 0, -PLATE_DIAMETER / 2 + PLATE_GAP_HEIGHT / 2, 0 ])
        cube([ PLATE_GAP_WIDTH, PLATE_GAP_HEIGHT, PLATE_WIDTH + epsilon ], center = true);
    rotate(a = -40) translate([ 0, -PLATE_DIAMETER / 2 + PLATE_GAP_HEIGHT / 2, 0 ])
        cube([ PLATE_GAP_WIDTH, PLATE_GAP_HEIGHT, PLATE_WIDTH + epsilon ], center = true);
}

translate([ 0, -HOOK_GAP_LENGTH / 2, PLATE_WIDTH / 2 + HOOK_HEIGHT / 2])
{
    translate([ HOOKS_DISTANCE / 2 + HOOK_WIDTH / 2, 0, 0 ]) vertical_hook();
    translate([ -HOOKS_DISTANCE / 2 - HOOK_WIDTH / 2, 0, 0 ]) vertical_hook();
}
translate([ 0, 0, PLATE_WIDTH / 2 + CONNECTOR_OUTSIDE_LENGTH ]) difference()
{
    sphere(r = CONNECTOR_DIAMETER / 2);
    translate([ 0, 0, -CONNECTOR_DIAMETER / 2 ]) cube(CONNECTOR_DIAMETER, center = true);
}
translate([ 0, 0, PLATE_WIDTH / 2 ]) cylinder(h = CONNECTOR_OUTSIDE_LENGTH, r = CONNECTOR_DIAMETER / 2);
translate([ 0, 0, PLATE_WIDTH / 2 + HOOK_HEIGHT / 2 ])
{
  translate([ 0, HOOKS_DISTANCE / 2 + HOOK_WIDTH / 2 - HOOK_GAP_LENGTH / 2, 0]) horizontal_hook();
  translate([ 0, -HOOKS_DISTANCE / 2 - HOOK_WIDTH / 2 - HOOK_GAP_LENGTH / 2, 0]) horizontal_hook();
}
