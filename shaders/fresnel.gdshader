shader_type spatial;
render_mode unshaded, blend_add;

float fresnel(float amount, vec3 normal, vec3 view) {
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void fragment() {
	vec3 base_color = vec3(0.0);
	float basic_fresnel = fresnel(3.0, NORMAL, VIEW);
	ALBEDO = base_color + basic_fresnel;
	ALPHA = basic_fresnel;
}
