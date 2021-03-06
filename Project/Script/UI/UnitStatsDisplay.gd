extends Control
class_name UnitStatsDisplay
export var name_path : NodePath
export var hp_path : NodePath
export var hp_text : NodePath
export var attack_path : NodePath 
export var defense_path : NodePath
export var mag_atk_path : NodePath
export var mag_def_path : NodePath
export var mov_path : NodePath
var name_value : Label
var hp_value : ProgressBar
var hp_text_value : Label
var attack_value : Label 
var defense_value : Label
var mag_atk_value : Label
var mag_def_value : Label
var mov_value : Label
func _ready():
	name_value = get_node(name_path)
	hp_value = get_node(hp_path)
	hp_text_value = get_node(hp_text)
	attack_value = get_node(attack_path)
	defense_value = get_node(defense_path)
	mag_atk_value = get_node(mag_atk_path)
	mag_def_value = get_node(mag_def_path)
	mov_value = get_node(mov_path)
func set_unit_stats(unit : Unit):
	name_value.text = unit.stats.name
	hp_value.max_value = unit.stats.hit_points
	hp_value.value = unit.hp
	hp_text_value.text = str(unit.hp) +"/"+ str(unit.stats.hit_points)
	attack_value.text = str(unit.stats.attack)
	defense_value.text = str(unit.stats.defense)
	mag_atk_value.text = str(unit.stats.magicAtk)
	mag_def_value.text = str(unit.stats.magicDef)
	mov_value.text = str(unit.stats.movement)
	pass