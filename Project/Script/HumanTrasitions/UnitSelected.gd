extends Transition
class_name UnitSelected
func _init(fsm).(fsm):
	pass
func entry_action():
	pass
func exit_action():
	pass
func is_triggered():
	return get_fsm_owner().tile_selected