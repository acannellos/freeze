shader_type spatial;
render_mode unshaded;

uniform vec4 color_a : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color_b : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	float x_offset = UV.y;
	float t = cos((UV.x + x_offset) * TAU * 4.0) * 0.5 + 0.5;

	ALBEDO = mix(color_a.rgb, color_b.rgb, t);
}