shader_type canvas_item;

uniform vec4 PROGRESS_COLOR : source_color;

void fragment() {
	// Place fragment code here.
	vec4 curr_color = texture(TEXTURE, UV);
	
	if (curr_color == vec4(1, 0, 0, 1))
	{
		COLOR = PROGRESS_COLOR;
	}
}
