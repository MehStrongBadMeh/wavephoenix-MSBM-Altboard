//Requires https://github.com/Irev-Dev/Round-Anything
include <Round-Anything/polyround.scad>

$fn = $preview ? 32 : 128;

//building pallete
show_building_pallete = true;
if (show_building_pallete)
{
    rotate([0,0,180]) translate([-9,0,1.0913]) rp2040_zero();
    translate([-7,0,0]) wavephoenix_board();
    case_main();
    translate([0,0,16]) case_cover();
    translate([0,11.3,3.2+5]) case_button();
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

module rp2040_zero()
{
    color("blue") import("G:/CAD/RP2040_Zero_stp/ImageToStl.com_RP2040_Zero/RP2040_Zero.stl");
}

module case_main()
{
    difference()
    {
        //main body
        translate([0,0,-2]) polyRoundExtrude([[-11,-25,2],[11,-25,2],[11,35,2],[-11,35,2]],8,0,1,$preview ? 10 : 40);
        //wavepheenix cut
        translate([0,0,6.9]) rotate([180,0,0]) union()
        {
            translate([0,0,-0.1]) polyRoundExtrude([[-7.1,-33,1],[7.1,-33,1],[7.1,5.25,1],[-7.1,5.25,1]],7-1.59,0,0,$preview ? 10 : 40); //board carve-out
            translate([0,0,-0.1]) polyRoundExtrude([[-7.1,-28.1,1],[7.1,-28.1,1],[7.1,5.25,1],[-7.1,5.25,1]],7,0,0,$preview ? 10 : 40); //deep board carve-out
        }
        polyRoundExtrude([[-9,-24,1],[9,-24,1],[9,0,1],[-9,0,1]],7,0,0,$preview ? 10 : 40); //rp2040-zero cut
        translate([-9/2,-27,1]) cube([9,8,3.5]); //usbc cut
        translate([-10/2,-24,-1]) cube([10,23,2]); //rp2040-zero basement
        translate([5+1.5,-23,-1]) cube([2.5,16,2]); //rp2040-zero wire basement
        translate([-(5+1.5)-2.5,-23,-1]) cube([2.5,16,2]); //rp2040-zero wire basement
    }
    //wavephoenix retention tabs
    translate([0,14,0.5+1.6]) union()
    {
        translate([-7.1,0,0]) cube([0.2,4,1], true);
        translate([7.1,0,0]) cube([0.2,4,1], true);
    }
    //rp2040-zero retention tabs
    translate([0,-6,0.5+1.1]) union()
    {
        translate([-9,0,0]) cube([0.3,4,1], true);
        translate([9,0,0]) cube([0.3,4,1], true);
    }
}

module case_cover()
{
    //color("red") rotate([180,0,0]) polyRoundExtrude([[-7.1,-33,1],[7.1,-33,1],[7.1,5.25,1],[-7.1,5.25,1]],1,0,0,$preview ? 10 : 40); //wave phoenix cut
    //color("red") translate([0,0,-1]) polyRoundExtrude([[-9,-24,1],[9,-24,1],[9,0,1],[-9,0,1]],2,0,0,$preview ? 10 : 40); //rp2040-zero cut
    difference()
    {
        union()
        {
            //main
            polyRoundExtrude([[-11,-25,2],[11,-25,2],[11,35,2],[-11,35,2]],1,1,0,$preview ? 10 : 40);
            //grip
            translate([0,0,-2]) linear_extrude(3) polygon(polyRound([[9,-24,1],[-9,-24,1],[-9,0,1],[-7.1,0,0],[-7.1,33,1],[7.1,33,1],[7.1,0,0],[9,0,1]],10));            
        }

        //grip cut
        translate([0,0,-4]) linear_extrude(3) polygon(polyRound([[8,-23,1],[-8,-23,1],[-8,-1,1],[-6.1,-1,0],[-6.1,32,1],[6.1,32,1],[6.1,-1,0],[8,-1,1]],10));
        //usbc cut
        translate([-9/2,-27,-5]) cube([9,8,3.5]); 
        //buton hole
        translate([0,11.3,-2]) cylinder(4,r=2); 
        //led hole
        translate([0,7.3,-2]) cylinder(2.6,r=1);
        //buton hole 1
        translate([4.5,-7.5,-2]) cylinder(4,r=1);
        //buton hole 2
        translate([-4.5,-7.5,-2]) cylinder(4,r=1); 
    }
}

module case_button()
{
    cylinder(1.6,r=2.6);
    polyRoundExtrude([[-1.8,-1.8,1.8],[1.8,-1.8,1.8],[1.8,1.8,1.8],[-1.8,1.8,1.8]],4.5,0.75,0,$preview ? 10 : 40);
}