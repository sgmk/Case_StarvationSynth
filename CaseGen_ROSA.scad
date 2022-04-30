
/// Case for everything
/// designed by dusjagr 2022
/// inspired by this: https://www.youtube.com/watch?v=lPgLZgnbREk
/// plidheightublic domain

$fn=50;
length = 85;
width = 55;
height = 25;
lidheight =8; //very weird parameter
wallThickness = 2;


filetRadius = 2.0001;
cornerRadius = 5.0001;
sideAngles = 1.05;

//screws
screwRadius = 2;
screwHeadRadius = 4;
headHeight = 5; 
headDrill = 0; // adjust for the screw head depth

// tailor the details with this
stepThickness = 2.0; // for the little rim to snap together
stepDepth = 3; // height the little rim to snap together, kinda relates on lid thickness
lidcorr =8; //some weird dependency on the wall thickness of the lid
engravingDepth = 1.8; // how deep to engrave
screwInset = 0.84; //how far to move the screws towards the center
portSize = 8; //size of the screwPort in ratio
portAngle = 3.5;

// the final models

//baseCase_round2(); //without screwports
//base(); // pure box
base_drilled(); // with engravings and holes
//top_screwholes();

//top drilling from external .dxf file and side by shapes here
module base_drilled(){
difference(){
  base();
  mirror([0,1,0]) rotate([0,0,180]) //holes in the top
    linear_extrude(height = 100, center = true, convexity = 10) import(file = "CaseGen_interface.dxf", layer = "drillHoles");
  translate([0,0,-2.4]) mirror([0,1,0]) rotate([0,0,180]) //engravings on top
    linear_extrude(height = engravingDepth, center = true, convexity = 10) import(file = "CaseGen_interface.dxf", layer = "engraving");
  translate([50,0,height-5]) rotate([0,90,0]) translate([0,0,-50]) roundedRect([8,15,100], 2);
  translate([length/5,50,15]) rotate([90,0,0]) cylinder(h=100,d=10,center=true); 
  translate([-length/5,50,15]) rotate([90,0,0]) cylinder(h=100,d=10,center=true); 

}
}


// top case with screwhead
module top_screwholes(){
difference(){
  top();
  translate([0,2*width+0,headDrill+2*filetRadius+2*wallThickness]) rotate([180,0,0])
    screwhead();
  }
}

// base case with screwholes
module base(){
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
          translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+0*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
          
          sphere(filetRadius);
      }
    }
  translate([0,0,1+2*height+wallThickness+lidheight-lidcorr]) cube([2*length,2*width,2*height],center=true);
  }
      screwhole();
} //end difference

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
  #translate([screwInset*-length/2,screwInset*-width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*-length/2,screwInset*width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
  translate([screwInset*length/2,screwInset*-width/2,screwLenght]) cylinder(h=screwHeight, r= screwRadius, center=true);
}
module screwhead() {

        // screw ports
  translate([screwInset*length/2,screwInset*width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
  translate([screwInset*-length/2,screwInset*-width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
  translate([screwInset*-length/2,screwInset*width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
  #translate([screwInset*length/2,screwInset*-width/2,0.5*height-wallThickness]) cylinder(h=headHeight, r= screwHeadRadius, center=true);
}



//needs to be fixed for thing top wall
module topCase_round3(){
difference(){    
  minkowski(){
    translate([0,0,0]) roundedRect([length+2*wallThickness-2*filetRadius, width+2*wallThickness-2*filetRadius, height+0*wallThickness+lidheight,sideAngles], cornerRadius+wallThickness);
    sphere(filetRadius);
    }
    
  minkowski(){ // This defines the size of the inside, as width / lenght above
    translate([0,0,+1*wallThickness-0.1*filetRadius]) roundedRect([length-2*filetRadius, width-2*filetRadius, height+2*wallThickness+0.5*filetRadius,sideAngles], cornerRadius);
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

   
