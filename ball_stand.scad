$fa = 1;
$fs = 0.5;

RING_INNER_DIAMETER = 20;
RING_THICKNESS = 5;
RING_HEIGHT = 10;
BALL_HEIGHT_OFF_GROUND = 5;
BAR_THICKNESS = RING_THICKNESS;
BAR_HEIGHT = RING_HEIGHT/2;

60_MM = 60;
2_POINT_5_INCHES = 63.5;
65_MM = 65;
70_MM = 70;
75_MM = 75;
3_INCHES = 76.2;
80_MM = 80;
85_MM = 85;
90_MM = 90;

ball_diameter = 3_INCHES;

module ring_outer(centre) {
    ring_inner_radius = RING_INNER_DIAMETER / 2;
    translate(centre)
    cylinder(RING_HEIGHT, ring_inner_radius + RING_THICKNESS, ring_inner_radius + RING_THICKNESS);
}
module ring_hole(centre) {
    ring_inner_radius = RING_INNER_DIAMETER / 2;
    translate(centre)
    translate([0,0,-1])
    cylinder(RING_HEIGHT + 2, ring_inner_radius, ring_inner_radius);
}
module bar(start, angle) {
    translate(start) 
        rotate(angle)
            cube([ball_diameter, BAR_THICKNESS, BAR_HEIGHT]);    
}
module ball(centre) {
    translate(centre)
    translate([0, 0, BALL_HEIGHT_OFF_GROUND + ball_diameter/2])
    sphere(d=ball_diameter);
}

d1 = ball_diameter * tan(30) / 2;
d2 = ball_diameter * sin(60) - d1;

p1 = [-ball_diameter/2, -d1, 0];
p2 = [ ball_diameter/2, -d1, 0];
p3 = [   0,  d2, 0];

difference() {
        union() {
            bar(p1, 0);
            bar(p2, 120);
            bar(p3, 240);
            ring_outer(p1);
            ring_outer(p2);
            ring_outer(p3);
        }
        union() {
            ring_hole(p1);
            ring_hole(p2);
            ring_hole(p3);            
        }
        union() {
            ball(p1);
            ball(p2);
            ball(p3);            
        }
}

