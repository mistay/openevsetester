$height=110;
$width=170;
$length=170;
 
$wandstaerke=5;
$fn=100;


$pcb_offset_y=65;
$rotaryencoder_offset_x=55.82;
$rotaryencoder_offset_y=45.74;
$display_offset=25;
$display_width = 27;
$display_height = 15;
$pcb_height=100;
$pcb_width = 100;

// center rotary encoder
$pcb_offset_x=($width - $pcb_width)/2 + ($rotaryencoder_offset_x-$pcb_width/2)/2;


// kleine clips
for (y=[60, 60+40, 60+40+40]) {
    translate([2,y,$wandstaerke])
        clip(5,10,9,5);
}

// großer clip
translate([$width-28,$length-50,$wandstaerke])
    rotate([0,0,0])
        clip(15,15,12,10,3);
    
module clip($width=10, $diameter=10, $height=10, $offset=10, $diameter_drill=2) {
    
    difference() {
        cube([$diameter+$offset,$width, $height]);

        translate([($diameter+$offset)/2, $width, $diameter/2])
            rotate([90,0,0])
                cylinder(d=$diameter, h=$width);

        // bohrungen
        for ($y=[$offset/4, $diameter +3*$offset/4])
            translate([$y, $width/2, 0])
                cylinder(d=$diameter_drill, h=$diameter);

    }
}




    
difference() {
    cube([$width, $length, $height]);
    translate([10, $wandstaerke/2, $wandstaerke])
        cube([$width-10*2, $length-$wandstaerke, $height]);
    translate([$wandstaerke/2, 10, $wandstaerke])
        cube([$width-$wandstaerke, $length-10*2, $height]);
    
    
    //todo: remove me, just for qa (fast-print, check if coordinates are ok
    translate([-.1,-.1,$wandstaerke])
        cube([$width+1, $length+1, $height]);
    
    //todo: remove me, just for qa (fast-print, check if coordinates are ok
    cube([$width+1, $length+1, $wandstaerke-3]);
    

    
    //zuleitungs ausschnitt
    translate([$width-25, $length+15, 30])
        rotate([90,0,0])
            cylinder(d=15, h=30);

    
    //gehäuse dome
    for (x=[5,$width-5]) {
        for (y=[5,$length-5]) {
            translate([x,y,$height-30])
                cylinder(d=6, h=31);
        }
    }

    // 3x schuko dosen
    translate([0, 50/2+7, -1]) {
        for (x=[$width/6, $width*3/6, $width*5/6]) {
            translate([x, 0, 0]) {
                cylinder(d=43, h=10);
            
                // bohrungen schuko
                for( bx=[38/2,-38/2]) {
                    for( by=[38/2,-38/2]) {
                        translate([bx, by,-.1])
                            cylinder(d=5, h=10);
                    }
                }
            }
        }
    }


    // power switch
    translate([27, $length - 35,-.1])
        cylinder(d=6, h=100);

    
    translate([$pcb_offset_x,$pcb_offset_y,-.1]) {
        
        translate([$rotaryencoder_offset_x, $rotaryencoder_offset_y,-1]) {
            // rotary encoder
            cylinder(d=10, h=100);
            
            


            translate([0,$display_offset,0]) {
                
                // display
                translate([-$display_width/2, -$display_height/2+3, 0])
                    cube([$display_width,$display_height,20]);
                
            }

        }
    }
}

module dome() {
    difference() {
        cylinder(d=6, h=10);
        cylinder(d=2, h=12);
    }
}


translate([$pcb_offset_x,$pcb_offset_y,$wandstaerke]) {
    
    difference() {
        cube([102,102,1]);
        translate([1,1,0])
            // pcb
            cube([100,100,10]);
    }
    
    translate([3,3,0])
        dome();

    translate([9,84,0])
        dome();

    translate([97,3,0])
        dome();

    translate([78,32,0])
        dome();

    translate([78,54,0])
        dome();

    translate([50,54,0])
        dome();

    translate([91,91,0])
        dome();
        
    translate([$rotaryencoder_offset_x, $rotaryencoder_offset_y,-1]) {
        translate([0,$display_offset,0]) {
            // bohrungen
            for (bx=[23/2, -23/2]) {
                for (by=[24/2, -24/2]) {
                    translate([bx, by, 0]) {
                        cylinder(d=2, h=5);
                    }
                }
            }
            
                translate([-30/2, -28/2, 0]) {
                    difference() {
                        cube([30,28,3]);
                        translate([.5,.5,0])
                            cube([30-1,28-1,30]);
                    }
                }
                
                
        }


    }
    

}