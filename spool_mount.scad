da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;

// 290.5 wide
// material thickness is 6.5

bearing_inner = 8;
bearing_outer = 22;
bearing_height = 7;

material_thickness = 6.1;

brace_thickness = 10;

frame_width_outer = 290.5;
frame_width_inner = 277;
frame_thickness = (frame_width_outer - frame_width_inner)/2;

mount_height = 40;
slot_depth = 25;

spool_width = 73;

brace_y = frame_width_inner/2-10;

module spool_x() {
  difference() {
    translate([0,brace_thickness/2,0])
      cube([frame_width_outer+brace_thickness*2,mount_height+brace_thickness,material_thickness],center=true);

    // bearing holes
    for(x=[0:4]) {
      for(side=[-1,1]) {
        translate([25*x*side,0,0]) {
          cylinder(r=bearing_inner*da8,h=material_thickness+1,center=true);
          % translate([0,0,material_thickness/2+bearing_height/2+0.5]) cylinder(r=bearing_outer*da8,h=bearing_height,center=true);
        }
      }
    }

    // mount slots
    for(side=[-1,1]) {
      translate([(frame_width_inner/2+frame_thickness/2)*side,-mount_height/2,0]) {
        cube([frame_thickness,mount_height*2,material_thickness+1],center=true);
      }
    }

    // brace slots
    for(side=[-1,1]) {
      translate([brace_y*side,0,0]) {
        cube([material_thickness,mount_height-brace_thickness*2,material_thickness+1],center=true);
      }
    }
  }
}

module spool_y() {
  difference() {
    union() {
      cube([spool_width,mount_height,material_thickness],center=true);
      cube([spool_width+material_thickness*2,mount_height-brace_thickness*2,material_thickness],center=true);
    }
    for(side=[-1,1]) {
      translate([side*(spool_width/2-5.5/2-0.5),0,0]) {
        // screw shaft
        cube([25,4.5,material_thickness+1],center=true);

        // captive nut
        cube([5.5,8.5,material_thickness+1],center=true);
      }
    }
  }
}
//translate([0,0,40]) spool_y();

module spool_plate() {
  translate([0,mount_height,0]) {
    //intersection() {
      spool_x();
      //translate([-frame_width_inner/2,0,0]) cube([mount_height,mount_height*3,mount_height],center=true);
    //}
  }
  translate([0,-mount_height,0]) {
    //intersection() {
      spool_y();
    //}
  }
}

module assembly() {
  color([1,1,1,.5]) {
    translate([0,-1*(spool_width/2+material_thickness/2+0.5),0]) rotate([0,0,180]) rotate([90,0,0]) spool_x();
    translate([0,(spool_width/2+material_thickness/2+0.5),0]) rotate([90,0,0]) spool_x();
  }
  color("turquoise") {
    for(side=[-1,1]) {
      translate([side*brace_y,0,0]) {
        rotate([0,0,90]) rotate([90,0,0]) spool_y();
      }
    }
  }
}

projection(cut=true) spool_plate();
assembly();
