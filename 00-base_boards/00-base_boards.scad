
// Board size in inches
// Should be integers
// At least 3x3
x = 19;
y = 12;

// Mount style
// 0: none
// 1: exes on each corner
// 2: Horizontal and vertical slots across the entire surface
// 3: As above but only on 2 rows along each edge
mountstyle = 3;

///////////////////////////////////

$fn=20;
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

module slot(x,y) {
    hull() {
        translate([-x/2,-y/2,0]) circle(mr/2);
        translate([x/2,y/2,0]) circle(mr/2);
    }
}

difference() {     
    hull() {        // The board itself
        translate([     0.5*mr,     0.5*mr,0]) circle(mr/2);
        translate([in*x-0.5*mr,     0.5*mr,0]) circle(mr/2);
        translate([     0.5*mr,in*y-0.5*mr,0]) circle(mr/2);
        translate([in*x-0.5*mr,in*y-0.5*mr,0]) circle(mr/2);
    }
    
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
        for(xc = [1 : 1 : x-1]) {
            for(yc = [1 : 1 : y-1]) {
                if ((xc + yc) % 2 == 0) translate([in*xc,in*yc,0]) slot(in,0);
                else    translate([in*xc,in*yc,0]) slot(0,in);
            }
        }
    }
        if (mountstyle == 3) {
        for(xc = [1 : 1 : x-1]) {
            for(yc = [1 : 1 : y-1]) {
                if (min(xc, yc) < 3 || xc > x-3 || yc > y-3) {
                    if ((xc + yc) % 2 == 0) translate([in*xc,in*yc,0]) slot(in,0);
                    else    translate([in*xc,in*yc,0]) slot(0,in);
                }
            }
        }
    }
}