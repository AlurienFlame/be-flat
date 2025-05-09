shader_type canvas_item;

uniform float fps = 6.0;
uniform int frame_count = 4;

void fragment() {
    int frame = int(mod(floor(TIME * fps), float(frame_count)));
    vec2 uv = UV;
    uv.x = uv.x / float(frame_count) + float(frame) / float(frame_count);
    COLOR = texture(TEXTURE, uv);
}