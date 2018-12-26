main_support_height = 3;
main_support_width = 10;

module main_structure() {
// upper horizontal side
hull() {
    cylinder(main_support_height, d=main_support_width);
    translate([174, 0, 0]) cylinder(3, d=main_support_width);
}

// lower horizontal side
translate([0, 103, 0]) hull() {
    cylinder(main_support_height, d=main_support_width);
    translate([174, 0, 0]) {
        cylinder(main_support_height, d=main_support_width);
    }
}

// central horizontal line
translate([4.5, 53, 0]) hull() {
    cylinder(main_support_height, d=main_support_width+5);
    translate([165, 0, 0]) cylinder(main_support_height, d=main_support_width+5);
}

// left vertical edge
hull() {
    cylinder(main_support_height, d=main_support_width);
    translate([0, 103, 0]) cylinder(main_support_height, d=main_support_width);
}

// right vertical edge
hull() {
    translate([174, 0, 0]) cylinder(main_support_height, d=main_support_width);
    translate([174, 103, 0]) cylinder(main_support_height, d=main_support_width);
}

// pads for rpi holder
translate([15, -5, 0]) {
    cylinder(main_support_height, d=main_support_width+4);
}
// 58mm between holes horizontally
translate([73, -5, 0]) {
    cylinder(main_support_height, d=main_support_width+4);
}
translate([73, 43, 0]) {
    cylinder(main_support_height, d=main_support_width+4);
}
translate([15, 43, 0]) {
    cylinder(main_support_height, d=main_support_width+4);
}

}

// rpi holder
module rpi_holder_standoff() {
    rpi_standoff_height = 3;
    difference() {
        cylinder(rpi_standoff_height, d=5);
        translate([0,0,-main_support_height]) 
            cylinder(rpi_standoff_height+main_support_height, d=3);
    }
}

module rpi_holder() {
    translate([0, 0, main_support_height]) rpi_holder_standoff();
    translate([58, 0, main_support_height]) rpi_holder_standoff();
    translate([0, 48.5, main_support_height]) rpi_holder_standoff();
    translate([58, 48.5, main_support_height]) rpi_holder_standoff();   
}

// wild thumper controller holder
module wild_thumper_controller_standoff() {
    controller_standoff_height = 10;
    controller_standoff_hole_diam = 2.8;
    controller_standoff_wall_thickness = 3;
    
    difference() {
        cylinder(controller_standoff_height, d=controller_standoff_wall_thickness*2+controller_standoff_hole_diam);
        translate([0, 0, -main_support_height])
            cylinder(controller_standoff_height+main_support_height, d=controller_standoff_hole_diam);
    }
}

module wild_thumper_controller_holder() {
    translate([4, 0, main_support_height]) wild_thumper_controller_standoff();
    translate([96, 0, main_support_height]) wild_thumper_controller_standoff();
    translate([4, 50, main_support_height]) wild_thumper_controller_standoff();
    translate([96, 50, main_support_height]) wild_thumper_controller_standoff();
}

difference() {
    main_structure();
    cylinder(main_support_height, d=3);
    translate([174, 0, 0])
        cylinder(main_support_height, d=3);
    translate([0, 103, 0])
        cylinder(main_support_height, d=3);
    translate([174, 103, 0])
        cylinder(main_support_height, d=3);
}
translate([15, -5, 0]) 
    rpi_holder();
translate([30, 53, 0]) 
    wild_thumper_controller_holder();
