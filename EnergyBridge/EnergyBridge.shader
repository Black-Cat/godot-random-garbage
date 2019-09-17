shader_type spatial;
render_mode unshaded, cull_disabled, world_vertex_coords;

uniform vec4 color : hint_color = vec4(1., 0., 0., 1.);
uniform float scale = 1.;
uniform float wave_scale = 1.;
uniform vec3 direction = vec3(1., 0., 0.); // Must be normalized
uniform float power = 1.;

void vertex() {
	// Rotate vertex toward X axis
	vec3 x_axis = vec3(1.,0.,0.);
	float rcos = dot(direction, x_axis);
	float rsin = length(cross(direction, x_axis));
	vec3 a = cross(direction, x_axis) / rsin;
	mat3 rot = mat3(
			vec3(a.x*a.x*(1.-rcos)+rcos,     a.x*a.y*(1.-rcos)-rsin*a.z, a.x*a.z*(1.-rcos)+rsin*a.y),
			vec3(a.x*a.y*(1.-rcos)+rsin*a.z, a.y*a.y*(1.-rcos)+rcos,     a.y*a.z*(1.-rcos)-rsin*a.x),
			vec3(a.x*a.z*(1.-rcos)-rsin*a.y, a.y*a.z*(1.-rcos)+rsin*a.x, a.z*a.z*(1.-rcos)+rcos));

	COLOR = vec4(VERTEX * rot, 0.);
}

float draw_up_line_edge(float pos, float start, float end) {
	return (step(start, pos) - step(end, pos)) * (1. - smoothstep(start, end, pos));
}

float draw_down_line_edge(float pos, float start, float end) {
	return (step(start, pos) - step(end, pos)) * smoothstep(start, end, pos);
}

float draw_inner_circle(vec2 pos, vec2 center, float start, float end) {
	float l = length(pos - center);
	return draw_down_line_edge(l, start, end);
}

float draw_outer_circle(vec2 pos, vec2 center, float start, float end) {
	float l = length(pos - center);
	return draw_up_line_edge(l, start, end);
}

void fragment() {
	vec2 uv = mod(COLOR.xz, 1./scale) * scale;

	ALPHA = draw_up_line_edge(uv.x,0.,.1);
	ALPHA += draw_down_line_edge(uv.x,.56,.66);
	ALPHA += draw_up_line_edge(uv.x,.66,.76);
	ALPHA += draw_down_line_edge(uv.x,.9,1.);

	ALPHA += draw_inner_circle(uv, vec2(.33),.13,.23);
	ALPHA += draw_outer_circle(uv, vec2(.33),.23,.33);

	ALPHA += draw_inner_circle(uv, vec2(.825),.01,.08);
	ALPHA += draw_outer_circle(uv, vec2(.825),.08,.165);

	float time_pos = mod(COLOR.x + mod(TIME, 1./wave_scale), 1./wave_scale) * wave_scale;
	float time_power = draw_up_line_edge(time_pos,0.,.5);
	time_power += draw_down_line_edge(time_pos,.5,1.);

	ALPHA *= time_power * power;

	ALBEDO = color.rgb;
}
