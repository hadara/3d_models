// this model is for a PCB holder that holds rpi3 and 
// Wild Thumper gen. 1 controller in the specific ip65 
// enclosure that I had lying around. As such it's probably
// not useful to anyone else in any direct way

main_support_height = 3;
main_support_beam_width = 10;
main_structure_width = 173.5;
main_structure_height = 104.5;

rpi_standoff_height = main_support_height+3;

controller_standoff_height = main_support_height+10;
controller_standoff_hole_diam = 2.8;
controller_standoff_wall_thickness = 1;

module rounded_beam(length, width=main_support_beam_width) {
    hull() {
        cylinder(main_support_height, d=width);
        translate([length, 0, 0]) 
            cylinder(main_support_height, d=width);
    }  
}

module _main_structure_positive() {
    // upper horizontal side
    rounded_beam(main_structure_width);
    // lower horizontal side
    translate([0, main_structure_height, 0]) 
        rounded_beam(main_structure_width);
    // central horizontal line. A bit wider than edges to accomodate pads
    translate([4.5, 53, 0]) 
        rounded_beam(165, width=main_support_beam_width+5);
    // left vertical edge
    rotate(90)
        rounded_beam(main_structure_height);
    // right vertical edge
    translate([main_structure_width, 0, 0])
        rotate(90)
            rounded_beam(main_structure_height);
    // pads for the rpi holder
    // 58mm between holes on horizontal axis
    pi_pad_coordinates = [[15, -5], [73, -5], [73, 43], [15, 43]];
    for (i=pi_pad_coordinates) {
        translate(i)
            cylinder(main_support_height, d=main_support_beam_width+4);
    }
}

module _main_structure_negative() {
    // screw holes
    main_struct_hole_coords = [[0, 0], [main_structure_width, 0], [0, main_structure_height], [main_structure_width, main_structure_height]];
    for (i=main_struct_hole_coords) {
        translate(i)
            cylinder(main_support_height, d=3);   
    }
}

module main_structure() {
    difference() {
        _main_structure_positive();
        _main_structure_negative();
    }
}

// rpi holder
module rpi_holder_standoff(action) {    
    if (action == "add") {
        cylinder(rpi_standoff_height+main_support_height, d=5);
    } else if (action == "remove") { 
        cylinder(rpi_standoff_height+main_support_height, d=3);
    }
}

module rpi_holder(action) {
    pi_standoff_coordinates = [[0, 0], [58, 0], [0, 48.5], [58, 48.5]];
    for (i=pi_standoff_coordinates) {
        translate(i) 
            rpi_holder_standoff(action);
    }
}

// wild thumper controller holder
module wild_thumper_controller_standoff(action) {
    if (action == "add") {
        cylinder(controller_standoff_height, d=controller_standoff_wall_thickness*2+controller_standoff_hole_diam);
    } else if (action == "remove") {
        cylinder(controller_standoff_height+main_support_height, d=controller_standoff_hole_diam);
    }
}

module wild_thumper_controller_holder(action) {
    controller_width = 100;
    controller_height = 60;
    screw_offset = 5;
    controller_standoff_coords = [
        [screw_offset, 0], 
        [controller_width-screw_offset, 0], 
        [screw_offset, controller_height-screw_offset*2], 
        [controller_width-screw_offset, controller_height-screw_offset*2]
    ];
    for (i=controller_standoff_coords) {
        translate(i) 
            wild_thumper_controller_standoff(action);
    }
}

rpi_holder_position = [15, -5, 0];
controller_position = [30, 55, 0];

difference() {
    union() {
        main_structure();
        translate(rpi_holder_position)
            rpi_holder("add");
        translate(controller_position) 
            wild_thumper_controller_holder("add");
    }
    // we have to take negatives (holes) from the subassemblies
    // since otherwise these wouldn't go through the base because
    // of the union()
    translate(rpi_holder_position) 
        rpi_holder("remove");
    translate(controller_position) 
        wild_thumper_controller_holder("remove");
}

