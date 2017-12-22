//!OpenSCAD
//Customizable Yagi Antenna Holder
//Oryginal by Blaz Bratus - Institute IRNAS Race - www.irnas.eu
//Upgraded by Szymon Reiter
//License: Creative Commons Attribution-ShareAlike 4.0 International License
//Version: 1.0

//Measure the required dimensions and insert in milimetres (mm)
rod_d=8; //diameter of the metal rod that functions as a dipole element
profile_b=15.1; //width of the profile that holds all the rods together
holder_l=80; //length of the holder
screw_d=3; //diameter of the screw that holds the rod in place
t=4; //thickness of the walls
add_screw=1; //  1 if you need additional screws to mount rod to holder (eg. holder for vibrator), otherwise set to 0



/*-------------------------DO-NOT-MODIFY!!!-(advanced-users-only)-------------------------*/


res=100;

module profile() {
    translate([0,0,profile_b/2])
    cube([profile_b,1000,profile_b],center=true); //profile that holds all the rods together
}

module rod() {
    rotate([0,90,0])
    cylinder(h=1000,r=rod_d/2,center=true,$fn=res); //metal rod that functions as a dipole element
}

module screw() {
    cylinder(h=1000,r=screw_d/2,center=true,$fn=res); //screw that holds the rod in place
}

module part() {
    difference() {
        union() {
            translate([0,0,(rod_d/2+2*t)/2])
            cube([holder_l-(rod_d+2*t),rod_d+2*t,rod_d/2+2*t],center=true); //the main body cube
            
            for (i=[-1,1]) { //two cilinders at both sides of the main body cube
                translate([i*(holder_l-(rod_d+2*t))/2,0,0])
                cylinder(h=rod_d/2+2*t,r=(rod_d+2*t)/2,center=false,$fn=res);
            }
        }
        
        translate([0,0,rod_d/2+t])
        profile();
        
        rod();
        
        screw();
        
        if (add_screw==1){
           if (holder_l>=75){
            translate([holder_l/2-2*t,0,0])
            screw();
            translate([-holder_l/2+2*t,0,0])
            screw();
              
            translate([profile_b+t/2,0,0])
            screw();
            translate([-profile_b-t/2,0,0])
            screw();}
        else{
            translate([holder_l/3,0,0])
            screw();
            translate([-holder_l/3,0,0])
            screw();
               }
            }
        }
     }

part();
