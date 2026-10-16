shader_type spatial;
uniform sampler2D heightmap_texture : hint_default_white;
uniform float height_scale = 2.0;

uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;
uniform vec4 albedo : source_color;


void vertex() {
    // Sample the red channel of the heightmap using UV coordinates
    float height = texture(heightmap_texture, UV).r;
    
    // Displace the vertex along the Y-axis (or along NORMAL)
    VERTEX.y += height * height_scale;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 albedo_tex = texture(texture_albedo,UV);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
