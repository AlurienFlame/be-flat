shader_type canvas_item;

uniform float fps = 4.0;
uniform int frame_count = 2;
uniform int columns = 1;


void fragment() {
    int frame = int(mod(floor(TIME * fps), float(frame_count)));
	int col = frame % columns;
    vec2 uv = UV;
    uv.x = uv.x + float(col) / float(columns);
    COLOR = texture(TEXTURE, uv);
}