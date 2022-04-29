
/// Case for everything
/// designed by dusjagr 2022
/// inspired by this: https://www.youtube.com/watch?v=lPgLZgnbREk
/// plidheightublic domain

$fn=50;
wallThickness = 3.6;
stepDepth = -1;
height = 25;
lidheight =5;
PCB = 1.6;
length = 85;
width = 55;
filetRadius = 2.01;
cornerRadius = 5.1;
sideAngles = 1.15;

//screws
screwPortRadius = 8;
screwRadius = 2;
screwHeadRadius = 4;

// tailor the details with this
headHeight = 8;
headDrill = -7;
stepThickness = 1.9;
lidcorr = 5;

base();

top_screwholes();

// top case with screwholes
module top_screwholes(){
difference(){
top();
    
translate([0,2*width+0,headDrill+2*filetRadius+2*wallThickness]) 
  rotate([180,0,0])
   screwhead();
}
}

// base case with screwholes
module base(){

baseCase_round2();

//screwports
difference(){
intersection(){ 
  screwports();
   minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
}

//moves the screwport lower
  translate([0,0,-2+2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
  
  screwhole();
}
}


// Top lid with screwhole
module top(){
translate([0,2*width+0,height+2*filetRadius+2*wallThickness]) 
rotate([180,0,0])
   difference(){
      topCase_round3();
      screwhole();
      

}

//screwports
translate([0,2*width+0,height+2*filetRadius+2*wallThickness]) 
rotate([180,0,0])
difference(){
intersection(){
intersection(){ 
  screwports();
   minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
}
  translate([0,0,1+2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
}
      screwhole();
}

}


module baseCase_round2(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+1*wallThickness+0.3*filetRadius,sideAngles], cornerRadius);
    sphere(filetRadius/sideAngles);
    }

  translate([0,0,2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
    
  // cut to see inside  
  //translate([0,-width,-height-lidheight]) cube([2*length,2*width,100],center=false);
    
  rimTop();
    }

}

screwHeight = 5*height+0.5*filetRadius;

screwInset = 0.88;

module screwports() {

        // screw ports
  translate([length/2,width/2,-height-wallThickness]) roundedRect([23,18,screwHeight],3);
  translate([-length/2,-width/2,-height-wallThickness]) roundedRect([23,18,screwHeight],3);
  translate([-length/2,width/2,-height-wallThickness]) roundedRect([23,18,screwHeight],3);
  translate([length/2,-width/2,-height-wallThickness]) roundedRect([23,18,screwHeight],3);

}


module screwports2() {

        // screw ports
  translate([length/2,width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwPortRadius, center=true);
  translate([-length/2,-width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwPortRadius, center=true);
  translate([-length/2,width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwPortRadius, center=true);
  translate([length/2,-width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwPortRadius, center=true);

}

module screwhole() {

        // screw ports
  translate([screwInset*length/2,screwInset*width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*-length/2,screwInset*-width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*-length/2,screwInset*width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*length/2,screwInset*-width/2,0.5*height-wallThickness]) cylinder(h=screwHeight, r= screwRadius, center=true);
}
module screwhead() {

        // screw ports
  translate([screwInset*length/2,screwInset*width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
  translate([screwInset*-length/2,screwInset*-width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
  translate([screwInset*-length/2,screwInset*width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
  translate([screwInset*length/2,screwInset*-width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
}

module topCase_round3(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+1*wallThickness+0.3*filetRadius,sideAngles], cornerRadius);
    sphere(filetRadius/sideAngles);
    }


    //translate([length-20,0,height-height+lidheight+wallThickness]) cube([2*length,2*width,2*height],center=true);
    
    // cut off
    difference(){ 
        translate([0,0,0]) cube([2*length,2*width,15*height],center=true);
          translate([0,0,2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);

    }
  //translate([0,-width,-height+lidheight+filetRadius/2]) cube([2*length,2*width,100],center=false);
  }
  
  rimTop();
  
}

module rimTop(){
translate([0,0,lidheight-5])
  difference(){ 
    scale([sideAngles*0.97,sideAngles*0.95,1]) minkowski(){
    translate([0,0,height-1*stepDepth+1.1]) roundedRect([length+2*stepThickness-0*filetRadius, width+2*stepThickness-0*filetRadius, 3,1], cornerRadius+stepThickness+filetRadius);
    sphere(filetRadius*0.001);
    }
    minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+1*wallThickness+0.3*filetRadius,sideAngles], cornerRadius);
    sphere(filetRadius/sideAngles);
    }
    } 

}


module baseCase(){

linear_extrude(height = height, center = false, convexity = 10) import(file = "BlindNoiseCase.dxf", layer = "Base");
}

// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];
    angle = size[3];

	translate([0,0,0])
	//linear_extrude(height=z)
    linear_extrude(height=z,scale=angle)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius, $fn=100);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius, $fn=100);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius, $fn=100);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius, $fn=100);
	}
  }

        
