
/// Case for everything
/// designed by dusjagr 2022
/// public domain
$fn=50;
wallThickness = 2.2;
stepThickness = 1.2;
stepDepth = 2;
height = 20;
lidheight = 5;
lidcorr = 5;
PCB = 1.6;
length = 80;
width = 45;
filetRadius = 2.01;
cornerRadius =10;
sideAngles = 1.05;


baseCase_round2();

//translate([0,2*width+0,height+2*filetRadius+2*wallThickness]) rotate([180,0,0])topCase_round3();

    
module baseCase_round(){
  minkowski(){
    baseCase();
    sphere(3);
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
    /*
  minkowski(){
    translate([0,0,height-stepDepth]) roundedRect([length+2*stepThickness-0*filetRadius, width+2*stepThickness-0*filetRadius, height,sideAngles], cornerRadius+stepThickness+filetRadius);
    //sphere(filetRadius*0.00001);
    }
    */
  translate([0,0,2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
    
  //translate([0,-width,-height-lidheight]) cube([2*length,2*width,100],center=false);
  }
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
    /*
  minkowski(){
    translate([0,0,height-stepDepth]) roundedRect([length+2*stepThickness-0*filetRadius, width+2*stepThickness-0*filetRadius, height,sideAngles], cornerRadius+stepThickness+filetRadius);
    //sphere(filetRadius*0.00001);
    }
    */
    //translate([length-20,0,height-height+lidheight+wallThickness]) cube([2*length,2*width,2*height],center=true);
    difference(){ 
        translate([0,0,0]) cube([2*length,2*width,15*height],center=true);
          translate([0,0,2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);

    }
  //translate([0,-width,-height+lidheight+filetRadius/2]) cube([2*length,2*width,100],center=false);
  }
}

module topCase_round2(){
difference(){    
  minkowski(){
    roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, lidheight], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,wallThickness]) roundedRect([length-2*filetRadius, width-2*filetRadius, 20+lidheight], cornerRadius);
    sphere(filetRadius);
    }
    
  translate([0,0,lidheight+filetRadius/2]) cube([2*length,2*width,filetRadius],center=true);
  }
  
  difference(){    
  minkowski(){ //the step
    translate([0,0,0]) roundedRect([length+2*stepThickness-0*filetRadius, width+2*stepThickness-0*filetRadius, stepDepth+lidheight], cornerRadius+stepThickness+filetRadius);
    //sphere(filetRadius*0.00001);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,wallThickness]) roundedRect([length-2*filetRadius, width-2*filetRadius, 50+lidheight], cornerRadius);
    sphere(filetRadius);
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

        
