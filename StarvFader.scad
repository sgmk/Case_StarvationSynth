/* [Basic] */
//Diametre du bouton
//Knob_Diameter=10; //[10:30]
Fader_Width=14; //[10:30]
Fader_Length=9; //[10:30]
//Hauteur du bouton
Knob_Height=12;//[10:20]
//Longueur de l'axe
Axis_Lenght=9.6;//[5:15]
Axis_Width = 0.8 ;
FaderAxis_Length = 4.6;
//Arrondis
Rounded=1.5;//[1:3]
//Ajustement
Ajustment=-0.1;//[0,0.1,0.2,0.3]
/* [Hidden] */
$fn=50;



rotate([180,0,0]) difference() {
  union() {
      //cylinder(r1=Knob_Diameter/2+1.6, r2=Knob_Diameter/2,h=Knob_Height-Rounded);
      //translate([-Fader_Length/2,-Fader_Width/2,0]) cube([Fader_Length,Fader_Width,Knob_Height-Rounded]);
      rotate([0,0,90]) linear_extrude(height = Knob_Height-Rounded, center = false, convexity = 10, scale=0.7) square([Fader_Length,Fader_Width],true);
      //translate([0,0,Knob_Height-Rounded]) cylinder(r=Fader_Width/2-Rounded,h=Rounded);
      //translate([0,0,Knob_Height-Rounded]) rotate_extrude(convexity = 10) translate([Fader_Width/2-Rounded,0,0])  circle(r=Rounded);
  }
  /*
  translate([0,-Fader_Width/2,Knob_Height-2*Rounded]) rotate([-90,0,0]) scale([1, 1, 1]) cylinder(r=1,h=Fader_Width);
  translate([0,-Fader_Width/2,Knob_Height-Rounded]) rotate([-90,0,0]) scale([Fader_Length/2, 2, 1]) cylinder(r=1,h=Fader_Width);
  translate([Fader_Length/3,-Fader_Width/2,Knob_Height-Rounded-1]) rotate([-90,0,0]) scale([2, 1, 1]) cylinder(r=Rounded,h=Fader_Width);
  translate([-Fader_Length/3,-Fader_Width/2,Knob_Height-Rounded-1]) rotate([-90,0,0]) scale([2, 1, 1]) cylinder(r=Rounded,h=Fader_Width);
*/
  difference() {
      translate([0,0,4]) cylinder(r=FaderAxis_Length/2+Ajustment,h=Axis_Lenght-4);
      translate([-5,-6-Axis_Width-0.1-Ajustment,2]) cube([10,6,Axis_Lenght-2]);
      translate([-5, Axis_Width+0.1+Ajustment,2]) cube([10,6,Axis_Lenght-2]);
  }
  difference() {
      translate([0,0,-0.01]) cylinder(r=FaderAxis_Length/2+Ajustment+0.6,h=4.1);
      translate([-5,-6-Axis_Width-0.2-Ajustment,0]) cube([10,6,Axis_Lenght-2]);
      translate([-5, Axis_Width+0.2+Ajustment,0]) cube([10,5,Axis_Lenght-2]);
  }
}
