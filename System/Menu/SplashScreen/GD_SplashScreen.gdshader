shader_type canvas_item;

uniform vec4 OUTLINE_COLOR : source_color;
uniform vec4 BG_COLOR : source_color;

void fragment() {
	// Place fragment code here.
	vec4 curr_color = texture(TEXTURE, UV);
	
	if (curr_color == vec4(0, 0, 0, 1))
	{
		COLOR = OUTLINE_COLOR;
	}
	else if (curr_color == vec4(1, 0, 0, 1))
	{
		COLOR = BG_COLOR;
	}
	
}
