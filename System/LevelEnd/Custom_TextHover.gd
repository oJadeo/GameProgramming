@tool
extends  RichTextEffect
class_name RichTextHover

var bbcode := "hover"

func _process_custom_fx(char_fx):
	var speed = char_fx.env.get("speed", 5.0)
	var amp = char_fx.env.get("amp", 1.0)
	var y_offset = char_fx.env.get("y_offset", 0.0)
	var offset := Vector2(0,sin(char_fx.elapsed_time * speed)*amp + y_offset)
	char_fx.offset = offset
	return true
