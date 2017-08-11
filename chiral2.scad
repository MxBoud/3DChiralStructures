circleRad = 6;
vAngle = 10;
armL = 40;


hPolygonSides =-5;
hAngle = 360/hPolygonSides;
numIter = 6;


$fn = 40;
difference(){

union(){
//Base 



translate([0,0,-6])
rotate_extrude(angle = 360){
translate([10,0,0])
minkowski(){
square([armL,1]);
circle(5);
}
}


//centered chiral helix
translate([-armL/2,-armL/(2*tan(180/hPolygonSides)),0]) //Align chiral helix to center.
union(){
//Arms 	
for (i=[0:1:numIter]){
translate(position(i)[0])	
rotate([0,-vAngle,position(i)[1]])
rotate([0,90,0])
linear_extrude(armL)
circle(circleRad);
}

//Connecting Spheres 
for (i=[0:1:numIter+1]){
translate(position(i)[0])
sphere(circleRad);
}
}
}

translate([0,-30,-2])
linear_extrude(4)
text("MB",halign = "center",valign = "center");
}
//This function calculate the position of every connecting spheres and the horizontal angle of every iterations
function position(n) = n == 0 ? [[0,0,0],0] : 
[
	[
		position(n-1)[0][0]+armL*cos(vAngle)*cos(position(n-1)[1]),
		position(n-1)[0][1]+armL*cos(vAngle)*sin(position(n-1)[1]),
		position(n-1)[0][2]+armL*sin(vAngle)], 
	position(n-1)[1]+hAngle
];

