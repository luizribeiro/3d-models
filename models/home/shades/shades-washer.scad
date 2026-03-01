// Model purpose: Simple washer/spacer for the shades mechanism, used to tune axial spacing and reduce friction or wobble between moving parts.
// Sized to the same family of shade components so it can be printed quickly as a fit-adjustment consumable.
$fn = 250;
epsilon = 0.01;
PLATE_DIAMETER = 31.95;
PLATE_WIDTH = 3.0;
HOLE_DIAMETER = 5.5;

difference()
{
    cylinder(r = PLATE_DIAMETER / 2, h = PLATE_WIDTH, center = true);
    cylinder(r = HOLE_DIAMETER / 2, h = PLATE_WIDTH + epsilon, center = true);
}
