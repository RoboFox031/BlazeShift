shader_type canvas_item;

uniform float disolveVar:hint_range(0.0, 1.0);
uniform sampler2D dissolveNoise;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 textureColor=texture(TEXTURE,UV);
	float brightness=texture(dissolveNoise,UV).r;
	COLOR=textureColor;
	COLOR.a*=step(disolveVar,brightness);
	float disolveDiff=abs(brightness-disolveVar);
	COLOR.rgb+=vec3(1,.6,0)*step(disolveDiff,0.05);
	// Called for every pixel the material is visible on.
}


