da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;

guide_diam = 6.5;
guide_length = 17;
holder_height = 26;
holder_clamp_depth = 8;

module spool_filament_holder(){
  difference() {
    translate([0,0,0]) cube([12,12,holder_height],center=true);

    translate([0,0,7]) {
      rotate([0,-45,45]) rotate([0,0,0]) {

        // main guide hole
        rotate([0,0,22.5]) {
          translate([0,0,4]) cylinder(r=guide_diam*da8,h=guide_length,$fn=8,center=true);

          // guide hole stop
          translate([0,0,0]) cylinder(r=guide_diam*da8-0.55,h=guide_length*3,$fn=8,center=true);
        }

        // square off hole ends
        translate([0,0,guide_length/2]) rotate([-5,40,0]) cube([guide_diam*4,guide_diam*4,8],center=true);
        translate([2,0,-guide_length/2-3]) cube([guide_diam+3,guide_diam*3,10],center=true);

        // rounded top
        for (r=[-45-22.5,-45,0,45,45+22.5]) {
          rotate([0,0,r]) translate([guide_diam/2+5,0,0]) cube([7,guide_length*2,guide_length],center=true);
        }
      }
    }



    translate([0,0,-holder_height/2]) cube([6,24,holder_clamp_depth*2],center=true);
  }
}

//spool_filament_holder();
rotate([90,0,0]) spool_filament_holder();
