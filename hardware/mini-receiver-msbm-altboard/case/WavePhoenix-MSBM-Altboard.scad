//Requires https://github.com/Irev-Dev/Round-Anything
include <Round-Anything/polyround.scad>

$fn = $preview ? 32 : 128;

//building pallete
show_building_pallete = true;
if (show_building_pallete)
{
    translate([-7,0,5.9]) rotate([180,0,0]) wavephoenix_board();
    case_main();
    translate([0,0,-10]) rotate([0,180,0]) case_cover();
    translate([0,-11.3,2.8-5]) rotate([0,180,0]) case_button();
}

//printing pallate
//case_main();
//translate([0,0,1]) rotate([0,180,0]) case_cover();
//case_button();

module wavephoenix_board()
{
    //mainboard
    color("purple") linear_extrude(1.6)
        polygon(polyRound([[0,0,1],[14,0,1],[14,28,1],[0,28,1]],10));
    
    //RF-BM-BG22A3
    translate([1,16.1625,1.6]) union()
    {
        difference()
        {
            color("blue") cube([12,16.7,0.76]);
            translate([2,12.5,-0.1]) linear_extrude(1)
            {
                polygon(polyRound([[0,0,0.5],[8,0,0.5],[8,1,0.5],[0,1,0.5]],10));
            }
        }
        
        color("grey") translate([1,1,0.5]) cube([10,11,2.2-0.5]);
    }
    
    //button
    translate([7,11.3,1.6]) import("G:/PCB/WavePhoenix/wavephoenix-main/hardware/mini-receiver/KiCad - Altboard/project-footprints/KEY-SMD_4P-L5.2-W5.2-H1.5-LS6.4-P3.70.stl");
    
    //led
    color("green") translate([7,7.3,1.6]) import("G:/PCB/WavePhoenix/wavephoenix-main/hardware/mini-receiver/KiCad - Altboard/project-footprints/LED0805-RD.stl");
    
    //connector
    translate([5.45,2.2,1.6]) import("G:/PCB/WavePhoenix/wavephoenix-main/hardware/mini-receiver/KiCad - Altboard/project-footprints/CONN-SMD_SR1.00-WS-4P.stl");
}


/*difference()
{
    color("red") translate([0,0,5.825+0.4]) import("G:/PCB/WavePhoenix/wavephoenix-main/hardware/mini-receiver/case/Main Case.stl");
    translate([-10,-30,0]) cube([10,40,40]); 
}*/
//color("red") translate([0,0,0.4]) import("G:/PCB/WavePhoenix/wavephoenix-main/hardware/mini-receiver/case/Main Case chop.stl");


module case_main()
{
    difference()
    {
        union()
        {
            //gamecube connector
            translate([0,0,5.9+1]) polyRoundExtrude([[-7.25,-7.25,7.25],[7.25,-7.25,7.25],[7.25,7.25,7.25],[-7.25,7.25,7.25]],21.4-5.9-1,1,0,$preview ? 10 : 40);
            //main body
            polyRoundExtrude([[-9,-35,2],[9,-35,2],[9,7.25,9],[-9,7.25,9]],17.9,1,0,$preview ? 10 : 40);
        }
        
        //Gamecube connector carve-out
        union()
        {
            difference()
            {
                translate([0,0,0]) cylinder(22, r=5.174);
                
                translate([-7,-6.625,-1]) cube([14,3,24]);
            }
            translate([0,0.775,22]) rotate([90,0,0]) linear_extrude(2.2)
                polygon([[-5.32766,-2.6],[0,-11.82],[5.32766,-2.6],[5.32766,1],[-5.32766,1]]);
            translate([0,0.775,20.3]) rotate([90,0,0]) linear_extrude(2.2)
                polygon([[-5.32766,-2.6],[0,-49.86],[5.32766,-2.6]]);
        }
        //board carve-out
        translate([0,0,-0.1]) polyRoundExtrude([[-7.1,-33,1],[7.1,-33,1],[7.1,5.25,7],[-7.1,5.25,7]],6-1.59,0,0,$preview ? 10 : 40);
        //deep board carve-out
        translate([0,0,-0.1]) polyRoundExtrude([[-7.1,-28.1,1],[7.1,-28.1,1],[7.1,5.25,7],[-7.1,5.25,7]],6,0,0,$preview ? 10 : 40);
    }
    //connector retention tab
    translate([-4,4.2211,3.895]) cube([8,2,2]);
    //board retention tabs - front
    translate([0,0,3.895]) linear_extrude(2)
        polygon([[-4,0.1],[-8,0.1],[-4,6]]);
    translate([0,0,3.895]) linear_extrude(2)
        polygon([[4,0.1],[8,0.1],[4,6]]);
    //board retention tabs - top
    translate([-7.1,-14,5.9-0.5-1.6]) cube([0.2,4,1], true);
    translate([7.1,-14,5.9-0.5-1.6]) cube([0.2,4,1], true);
}

module case_cover()
{
    difference()
    {
        union()
        {
            //main
            polyRoundExtrude([[-9,-35,2],[9,-35,2],[9,7.25,9],[-9,7.25,9]],1,1,0,$preview ? 10 : 40);
            //interiorgrip
            translate([0,0,-2.2]) polyRoundExtrude([[-7.15,-32.9,1],[7.15,-32.9,1],[7.1,5.25,7],[-7.1,5.25,7]],3.2,0,0,$preview ? 10 : 40);
        }
        //buton hole
        translate([0,-11.3,-2]) cylinder(4,r=2);
        //led hole
        translate([0,-7.3,-2]) cylinder(2.6,r=1);
        //interior cutout
        translate([0,0,-2.2-1]) polyRoundExtrude([[-5,-32,1],[5,-32,1],[5,4.25,6],[-5,4.25,6]],1.2+1,0,0,$preview ? 10 : 40);
    }
}

module case_button()
{
    cylinder(1.1,r=2.6);
    polyRoundExtrude([[-1.8,-1.8,1.8],[1.8,-1.8,1.8],[1.8,1.8,1.8],[-1.8,1.8,1.8]],4,0.75,0,$preview ? 10 : 40);
}