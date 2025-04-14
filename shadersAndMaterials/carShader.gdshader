shader_type canvas_item;
uniform vec4 replaceColor:source_color;
uniform vec4 newColor:source_color;
//the color won't be exactly right, so a small tolrance is needed
const float colorTolerance=0.01;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//Calculates the color of each pixle
	vec4 pixleColor=texture(TEXTURE,UV);
	//Calculates the distance of that color to the color you are swaping to
	float colorDist=distance(pixleColor.rgb,replaceColor.rgb);
	//if the distance is within tolerance, then swich the color
	if(colorDist<colorTolerance){
		COLOR.rgb=newColor.rgb;
	}
	//if it's outside tolerance keep the color
	else{
		COLOR.rgb=pixleColor.rgb;
	}
	//preserve trancparancy of sprite
	COLOR.a=pixleColor.a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
