/* [Basic] */
//Diametre du bouton
Knob_Diameter=10.7; //[10:30]
// inner Diameter
Shaft_Diameter = 4.0;
//Hauteur du bouton
Knob_Height=12;//[10:20]
//Longueur de l'axe
Axis_Lenght=12;//[5:15]
//Arrondis
Rounded=2;//[1:3]
//Ajustement
Ajustment=0.25;//[0,0.1,0.2,0.3]
/* [Hidden] */
$fn=100;



rotate([180,0,0]) difference() {
  union() {
      cylinder(r1=Knob_Diameter/2+1.0, r2=Knob_Diameter/2,h=Knob_Height-Rounded);
      translate([0,0,Knob_Height-Rounded]) cylinder(r=Knob_Diameter/2-Rounded,h=Rounded);
      translate([0,0,Knob_Height-Rounded]) rotate_extrude(convexity = 10) translate([Knob_Diameter/2-Rounded,0,0])  circle(r=Rounded);
  }
  
    translate([0,0,Knob_Height]) rotate([90,0,0]) cylinder(r=0.8,h=Knob_Diameter/2);
  translate([0,0,Knob_Height]) sphere(r=0.8);
  translate([0,-Knob_Diameter/2-0.6,3]) cylinder(r=1.2,h=Knob_Height);
    for (i=[0:60:360]) translate([(Knob_Diameter+0.6)*sin(i)/2,(Knob_Diameter+0.6)*cos(i)/2,3])  cylinder(r1=0.7, r2=0.7*1,h=Knob_Height);

  difference() {
      translate([0,0,2-0.11]) cylinder(r=Shaft_Diameter/2+Ajustment,h=Axis_Lenght-3);
      translate([-5,1.2+Ajustment,2]) cube([10,5,Axis_Lenght-1]);
  }
  difference() { // inner
      translate([0,0,-0.1]) cylinder(r=Shaft_Diameter/2+Ajustment,h=5);
      //translate([-5,-6.5-Ajustment,0]) cube([10,5,Axis_Lenght-2]);
  }
  
}

