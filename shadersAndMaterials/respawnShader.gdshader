shader_type canvas_item;

uniform float disolveVar:hint_range(0.0, 1.1);
uniform sampler2D dissolveNoise;
uniform vec4 dissolveColor:source_color;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 textureColor=texture(TEXTURE,UV);
	float brightness=texture(dissolveNoise,UV).r+.1;
	COLOR=textureColor;
	COLOR.a*=step(disolveVar,brightness);
	float disolveDiff=abs(brightness-disolveVar);
	COLOR.rgb+=dissolveColor.rgb*step(disolveDiff,0.05);
	// Called for every pixel the material is visible on.
}
