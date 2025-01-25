shader_type canvas_item;

uniform float intensity : hint_range(0.0, 5.0) = 0.4;
uniform float edge_fade : hint_range(0.0, 1.0) = 0.6;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec4 glow_color = vec4(1.0, 1.0, 1.0, 1.0);

	float alpha_edge = smoothstep(0.0, edge_fade, tex_color.a);
	vec4 shine = glow_color * intensity * alpha_edge;

    COLOR = tex_color + shine;
}