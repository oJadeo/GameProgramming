class_name Status

signal atk_updated(new_value)
signal def_updated(new_value)
signal speed_updated(new_value)
signal health_updated(new_value)
signal max_health_updated(new_value)
signal gauge_updated(new_value)
signal death
var atk: int = 0:
	set(new_value):
		atk = new_value
		emit_signal('atk_updated',new_value)
var def: int = 0:
	set(new_value):
		def = new_value
		emit_signal('def_updated',new_value)
var speed: int = 10:
	set(new_value):
		speed = new_value
		emit_signal('speed_updated',new_value)
var health: int = 0:
	set(new_value):
		if new_value <= 0:
			health = 0
			emit_signal('health_updated',new_value)
			emit_signal('death')
			return
		health = new_value if new_value < max_health else max_health
		emit_signal('health_updated',health)
var max_health:int = 0:
	set(new_value):
		max_health = new_value
		emit_signal('max_health_updated',new_value)
var gauge:float = 0.0:
	set(new_value):
		gauge = new_value 
		emit_signal('gauge_updated',new_value)
func _init():
	pass
