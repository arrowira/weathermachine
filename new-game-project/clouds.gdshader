shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform vec3 albedo : source_color = vec3(1.0);
uniform float roughness : hint_range(0,1) = 0.5;
uniform float metallic : hint_range(0,1) = 0.0;

// Controls where the fade starts (0.0 = bottom, 1.0 = top)
uniform float fade_start : hint_range(-1.0, 1.0) = -0.5;
// Controls how quickly the fade happens
uniform float fade_length : hint_range(0.0, 1.0) = 0.5;

varying float v_y_pos;

void vertex() {
	// Pass the local vertex Y position to the fragment shader
	v_y_pos = VERTEX.y;
}

void fragment() {
	// Set material properties
	ALBEDO = albedo;
	ROUGHNESS = roughness;
	METALLIC = metallic;

	// Calculate alpha based on vertical position
	// Smoothstep creates a smooth transition between Opaque(1) and Transparent(0)
	float fade = smoothstep(fade_start, fade_start + fade_length, v_y_pos);
	
	// Apply fade to alpha
	ALPHA = fade;
}
