
/// Case for everything
/// designed by dusjagr 2022
/// inspired by this: https://www.youtube.com/watch?v=lPgLZgnbREk
/// plidheightublic domain

$fn=50;
length = 110;
width = 50;
height = 20;
lidheight =5; //very weird parameter
wallThickness = 2.4;


filetRadius = 2.5001;
cornerRadius = 0.0001;
sideAngles = 1.0;

//screws
screwRadius = 1.5;
screwHeadRadius = 4;
headHeight = 3; 
headDrill = -1.8; // adjust for the screw head depth

// tailor the details with this
stepThickness = 3.0; // for the little rim to snap together
stepDiff = 0.0; // To make sure the snap together. 0.2 - 0.5
stepDepth = -0.6; // height the little rim to snap together, kinda relates on lid thickness
lidcorr = 5; //some weird dependency on the wall thickness of the lid
innerVolZ = -0.5;
engravingDepth = 5; // how deep to engrave
screwInset = 0.93; //how far to move the screws towards the center
portSize = 5; //size of the screwPort in ratio
portAngle = 3;

// the final models

//baseCase_round2(); //without screwports
//base_drilled(); // pure box
base_engraved(); // with engravings and holes

//translate([0,0,55]) PCB();

//translate([0,0,0]) topCase_round3();
//top();
//top_drilled();

module PCB(){
  difference(){  
      union(){
    translate([0,0,0]) mirror([0,0,0]) rotate([0,0,90]) //engravings on top
    linear_extrude(height = 0.8, center = true, convexity = 10) import(file = "starvation_pcb.dxf", layer = "pcbBorder");
    
    translate([0,0,-2.4]) mirror([0,0,0]) rotate([0,0,90])
    linear_extrude(height = 5.2, center = true, convexity = 10) import(file = "starvation_pcb.dxf", layer = "3d_parts");
      }
      
    translate([0,0,-2.4]) mirror([0,0,0]) rotate([0,0,90]) //engravings on top
    linear_extrude(height = 1, center = true, convexity = 10) import(file = "starvation_pcb.dxf", layer = "holes");
      
  }
}


//top drilling from external .dxf file and side by shapes here
module base_engraved(){
difference(){  
  base_drilled();
  mirror([0,1,0]) rotate([0,0,180]) //holes in the top
    //linear_extrude(height = 100, center = true, convexity = 10) import(file = "CaseGen_interface_mini.dxf", layer = "drillHoles");
  translate([0,0,-2.4]) mirror([0,0,0]) rotate([0,0,-90]) //engravings on top
    linear_extrude(height = engravingDepth, center = true, convexity = 10) import(file = "starvation_pcb.dxf", layer = "CaseOpenings");
  //translate([50,6,height-18]) rotate([0,90,0]) translate([0,0,-50]) roundedRect([10,10,100], 2);
  //translate([length/5,50,12]) rotate([90,0,0]) cylinder(h=100,d=12.5,center=true); 
  //translate([-length/5,50,12]) rotate([90,0,0]) cylinder(h=100,d=12.5,center=true); 

  }
  //screw ports pcb
  translate([0,0,2]) mirror([0,1,0]) rotate([0,0,90])
    linear_extrude(height = 8, center = true, convexity = 10) import(file = "starvation_pcb.dxf", layer = "holes");
}


// base case with screwholes
module base_drilled(){
baseCase_round2();
difference(){ 
  intersection(){ //make sure all the screwport volume is inside the box
    screwports();
    minkowski(){
      translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*   wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
      sphere(filetRadius);
      }
  }
  
  screwhole(); //drill the screwholes
  
  //cuts the screwport below the rim
    translate([0,0,-2+2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
  }
}

// this is just to move it to the side...

module top(){
translate([0,2*width+0,height+2*filetRadius+2*wallThickness]) 
rotate([180,0,0]) 
    topCase_round3();
}


// Top lid with screwhole
module top_drilled(){
translate([0,2*width+0,height+2*filetRadius+2*wallThickness]) 
rotate([180,0,0])
  difference(){
    topCase_round3();
    screwhole();  
    translate([0,0,-headDrill+height])
      screwhead();   
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
      screwhole2();
      translate([0,0,-headDrill+height])
        screwhead(); 
      
} //end difference

}


module baseCase_round2(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,innerVolZ+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+1*wallThickness+0.3*filetRadius,sideAngles], cornerRadius);
    sphere(filetRadius/sideAngles);
    }

  translate([0,0,2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
    
  // cut to see inside  
  //translate([0,-width,-height-lidheight]) cube([2*length,2*width,100],center=false);
    
  rimBody();
  }

}

//screwHeight = 5*height+1*filetRadius;
screwHeight = 1.5*height+1*filetRadius+lidheight;
portHeight =  1.5*height+1*filetRadius+lidheight;
screwLenght = 2+portHeight/2+height/2;


module screwports() {

        // screw ports
  translate([length/2,width/2,-wallThickness]) roundedRect([portSize*1.25,portSize*1,portHeight,portAngle],1);
  translate([-length/2,-width/2,-wallThickness]) roundedRect([portSize*1.25,portSize*1,portHeight,portAngle],1);
  translate([-length/2,width/2,-wallThickness]) roundedRect([portSize*1.25,portSize*1,portHeight,portAngle],1);
  translate([length/2,-width/2,-wallThickness]) roundedRect([portSize*1.25,portSize*1,portHeight,portAngle],1);

}

module screwhole() {

        // screw ports
  translate([screwInset*length/2,screwInset*width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*-length/2,screwInset*-width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*-length/2,screwInset*width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*length/2,screwInset*-width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
}

module screwhole2() {

        // screw ports
  translate([screwInset*length/2,screwInset*width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius*1.2, center=true);
  translate([screwInset*-length/2,screwInset*-width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius*1.2, center=true);
  #translate([screwInset*-length/2,screwInset*width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius*1.2, center=true);
  translate([screwInset*length/2,screwInset*-width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius*1.2, center=true);
}

module screwhead() {

        // screw ports
  translate([screwInset*length/2,screwInset*width/2,0.5*height-wallThickness+2]) cylinder(h=headHeight, r1= screwHeadRadius/1.8,r2=screwHeadRadius, center=true);
  translate([screwInset*-length/2,screwInset*-width/2,0.5*height-wallThickness+2]) cylinder(h=headHeight, r1= screwHeadRadius/1.8,r2=screwHeadRadius, center=true);
  translate([screwInset*-length/2,screwInset*width/2,0.5*height-wallThickness+2]) cylinder(h=headHeight, r1= screwHeadRadius/1.8,r2=screwHeadRadius, center=true);
  translate([screwInset*length/2,screwInset*-width/2,0.5*height-wallThickness+2]) cylinder(h=headHeight, r1= screwHeadRadius/1.8,r2=screwHeadRadius, center=true);
}



//needs to be fixed for thing top wall
module topCase_round3_bak(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+0*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,innerVolZ+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+2*wallThickness+0.5*filetRadius,sideAngles], cornerRadius);
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

module baseCase_round2_bak(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,innerVolZ+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+1*wallThickness+0.3*filetRadius,sideAngles], cornerRadius);
    sphere(filetRadius/sideAngles);
    }

  translate([0,0,2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
    
  // cut to see inside  
  translate([0,-width,-height-lidheight]) cube([2*length,2*width,100],center=false);
    
  rimBody();
  }

}

module topCase_round3(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+2*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,innerVolZ+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+2*wallThickness+0.5*filetRadius,sideAngles], cornerRadius);
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

module rimBody(){
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

module rimTop(){
translate([0,0,lidheight-5])
  difference(){ 
    scale([sideAngles*0.97,sideAngles*0.95,1]) minkowski(){
    translate([0,0,height-1*stepDepth+1.1]) roundedRect([length+2*stepThickness-stepDiff*filetRadius, width+2*stepThickness-stepDiff*filetRadius, 3,1], cornerRadius+stepThickness-stepDiff+filetRadius);
    sphere(filetRadius*0.001);
    }
    minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+1*wallThickness+0.3*filetRadius,sideAngles], cornerRadius);
    sphere(filetRadius/sideAngles);
    }
    } 

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

  
// radius - radius of corners
module roundedRect2(size, radius)
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

   
