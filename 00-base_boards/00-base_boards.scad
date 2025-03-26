
// Board size in inches
// Should be integers
// At least 3x3
x = 5;
y = 5;

// Mount style
// 0: none
// 1: exes on each corner
// 2: slots along the edges
mountstyle=2;

///////////////////////////////////

$fn=100;
in = 25.4;
dr = 2.5;   // Drill hole size
mr = 3.2;   // Mount hole size

module ex() {
        hull() {
            translate([in*0.5+1.5*dr,in*0.5+1.5*dr,0]) circle(mr/2);
            translate([in*1.5-1.5*dr,in*1.5-1.5*dr,0]) circle(mr/2);
        }
        hull() {
            translate([in*0.5+1.5*dr,in*1.5-1.5*dr,0]) circle(mr/2);
            translate([in*1.5-1.5*dr,in*0.5+1.5*dr,0]) circle(mr/2);
        }
}

difference() {
    square([x*in,y*in]);        // The board itself
    for(xc = [0.5 : 1 : x]) {   // Pegboard holes
        for(yc = [0.5 : 1 : y]) {
            translate([xc * in, yc*in,0]) circle(dr/2);
        }
    }
    
    if (mountstyle == 1) {
        translate([       0,        0, 0]) ex();
        translate([(x-2)*in,        0, 0]) ex();
        translate([       0, (y-2)*in, 0]) ex();
        translate([(x-2)*in, (y-2)*in, 0]) ex();
    }
    if (mountstyle == 2) {
        for(xc = [1 : 1 : x-1]) {   // Horizontal slots
            z = xc % 2;
            for(yc = [0.5+z : 2 : y-1]) {
                hull() {
                    translate([in*(xc-0.5),in*(yc+0.5),0]) circle(mr/2);
                    translate([in*(xc+0.5),in*(yc+0.5),0]) circle(mr/2);
                }
            }
        }
        for(xc = [1 : 1 : x-1]) {   // Vertical slots
            z = 1-(xc % 2);
            for(yc = [0.5+z : 2 : y-1]) {
                hull() {
                    translate([in*(xc),in*(yc+1),0]) circle(mr/2);
                    translate([in*(xc),in*(yc),0]) circle(mr/2);
                }
            }
        }
    }
}