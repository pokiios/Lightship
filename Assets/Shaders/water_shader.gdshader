shader_type spatial;

// Colour
uniform vec4 color : source_color = vec4(1,1,1,1);
uniform vec4 fresnel_color : source_color = vec4(1,1,1,1);
uniform vec4 depth_color: source_color = vec4(1,1,1,1);
uniform vec4 foam_color: source_color = vec4(1,1,1,1);

// maps
uniform sampler2D normal_1;
uniform sampler2D normal_2;
uniform sampler2D texture_1;
uniform sampler2D texture_2;
uniform sampler2D wave;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Texture settings
uniform float transparency: hint_range(0.0,1.0,0.01) = 1.0;
uniform float metallic : hint_range(0.0, 1.0) = 0;
uniform float roughness : hint_range(0.0, 1.0) = 0.02;

// Movement
uniform vec2 wave_direction = vec2(2.0,0.0);
uniform vec2 wave_direction2 = vec2(0.0, 1.0);
uniform float time_scale : hint_range(0.0, 0.2, 0.005) = 0.025;

// wave
uniform float noise_scale = 10.0;
uniform float height_scale = 0.15;
uniform float beers_law = 2.0;
uniform float depth_offset = -0.75;

// Varying variables (wtf is this)
varying float height;
varying vec3 world_position;


void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	height = texture(wave, world_position.xz / noise_scale + TIME * time_scale).r;
	VERTEX.y += height * height_scale;
}

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

void fragment() {
	float depth_texture = texture(DEPTH_TEXTURE, SCREEN_UV).r * 2.0 - 1.0;
	float depth = PROJECTION_MATRIX[3][2] / (depth_texture + PROJECTION_MATRIX[2][2]);
	float depth_blend = exp((depth+VERTEX.z + depth_offset) * -beers_law); 
	depth_blend = clamp(1.0 - depth_blend, 0.0, 1.0);
	float depth_blend_power = clamp(pow(depth_blend, 2.5), 0.0, 1.0);
	
	vec3 screen_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, depth_blend_power * 2.5).rgb;
	vec3 depth_blend_color = mix(color.rgb, depth_color.rgb, depth_blend_power);
	vec3 color_blend = mix(screen_color * depth_color.rgb, depth_color.rgb * 0.25, depth_blend_power * 0.5);
	
	
	vec2 time = (TIME * wave_direction) * time_scale;
	vec2 time2 = (TIME * wave_direction2) * time_scale;
	vec3 normal_blend = mix(texture(normal_1,world_position.xz + time).rgb, texture(normal_2,UV + time2).rgb, 0.5);
	
	float fresnel = fresnel(5.0, NORMAL, VIEW);
	vec3 surface_color = mix(color.rgb, fresnel_color.rgb, fresnel);
	
	// Set attributes
	NORMAL_MAP = normal_blend;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	ALBEDO = mix(surface_color, color_blend, 0.75);
}