screwport = [6, 6, 6];
chassis_attach_hole_diam = 7;
chassis_attach_wall_thickness = 2.5;
chassis_attach_height = 6;

module ScrewBox() {
  difference() {
    hull() {
        cube(screwport);
        translate([0,6,0]) {
          rotate([90,90,0]) {
            linear_extrude(height=6, convexity=10, twist=0) {
                polygon(points=[[0,0], [6,0], [0,6]]);
            }
          }
        }
    }
    translate([3,3,1]) {
      cylinder(6, d=2.5);
    }
  }
}

module ChassisAttach(x, y) {
    translate([x,y]) {
        difference() {
            cylinder(chassis_attach_height, d=chassis_attach_hole_diam+chassis_attach_wall_thickness*2);
            cylinder(chassis_attach_height, d=chassis_attach_hole_diam);
        }
    }
}

difference() {
    cube([120, 45, 25]);
    translate([2, 2, 2]) {
        cube([116, 41, 24]);
    }
}

translate([118, 37, 19])
  mirror([1,0,0])
    ScrewBox();
translate([118,2,19])
  mirror([1,0,0])
      ScrewBox();
translate([2,37,19]) ScrewBox();
translate([2,2,19]) ScrewBox();


ChassisAttach(10, -3.5);
ChassisAttach(10, 48.5);
ChassisAttach(110, -3.5);
ChassisAttach(110, 48.5);