shader_type canvas_item;

uniform float fps = 6.0;
uniform int columns = 4;
uniform int rows = 3;

void fragment() {
    int total_frames = columns * rows;
    int frame = int(mod(floor(TIME * fps), float(total_frames)));

    int col = frame % columns;
    int row = frame / columns;

    vec2 frame_size = vec2(1.0 / float(columns), 1.0 / float(rows));
    vec2 uv = UV * frame_size + vec2(float(col), float(row)) * frame_size;

    COLOR = texture(TEXTURE, uv);
}
