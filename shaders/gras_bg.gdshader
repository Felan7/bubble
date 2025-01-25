shader_type canvas_item;

uniform vec2 texture_scale = vec2(1.0, 1.0);

void fragment() {
    vec2 uv = FRAGCOORD.xy / texture_scale;
    COLOR = texture(TEXTURE, uv);
}