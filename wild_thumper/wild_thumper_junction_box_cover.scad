cover_thickness = 3;

module screw_hole() {
    hull() {
        translate([0,0,0]) cylinder(1, d=2.5);
        translate([0,0,cover_thickness-1]) cylinder(1, d=3.5);
    }
}

 difference() {
    cube([120, 45, cover_thickness]);

    translate([115, 40, 0]) screw_hole();
    translate([115, 5, 0]) screw_hole();
    translate([5, 40, 0]) screw_hole();
    translate([5, 5, 0]) screw_hole();
}
