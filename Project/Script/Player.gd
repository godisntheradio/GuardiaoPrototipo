extends Spatial
class_name Player


func begin_turn():
	pass
func end_turn():
	emit_signal("end_turn")
	pass