extends Control

var item_list
var UnitClass = preload("res://Objects/Unit.tscn")
var input
var map

var to_be_positioned
var to_be_positioned_index

func _ready():
	item_list = get_node("Panel/ItemList")
	item_list.connect("item_activated",self,"_on_selected_from_list")
	map = get_tree().get_root().get_node("Main/Map")
	input = get_tree().get_root().get_node("Main/PlayerInput")
	# load list
	item_list.set_same_column_width(true)
	item_list.set_max_text_lines(50)
	item_list.set_auto_height(true)
	for unit in PlayerData.available_units:
		item_list.add_item(unit.name + "   " )


func _physics_process(delta):
	if(to_be_positioned != null):
		if(input.result.size() > 0):
			var tile = input.result.collider.get_parent()
			if(tile is Tile):
				to_be_positioned.global_transform.origin = tile.global_transform.origin + Vector3(0,3.0,0)
		else:
			to_be_positioned.global_transform.origin = input.dir.normalized() * 2
	pass
func _process(delta):
	if(Input.is_action_pressed("left_click")): # clique esquerdo posiciona uma unidade selecionada na lista no campo
		if(input.result.size() > 0 && to_be_positioned != null):#checa se o raycast colidiu com algo e se há uma unidade selecionada para posicionar
			var tile = input.result.collider.get_parent()
			if(tile is Tile):
				position_unit(to_be_positioned, tile)
	if(Input.is_action_just_released("right_click")): # clique direito tira uma unidade do campo e retorna para a lista caso deseje reposicionar
		if(input.result.size() > 0 && to_be_positioned == null): #checa se o raycast colidiu com algo e se nao tem nada selecionado para posicionar
			var tile = input.result.collider.get_parent()
			if(tile is Tile && tile.occupying_unit != null): #chega se a colisao foi com um tile e se tile possui uma unidade para tirar do campo
				var i = PlayerData.find_unit_index(tile.occupying_unit)
				print(tile.occupying_unit.stats.name + str(i))
				reactivate(i)
				tile.remove_unit()
	
func position_unit(new_unit : Unit, tile : Tile):
	if(tile.occupying_unit == null):
		tile.occupying_unit = new_unit
		deactivate()
	pass
func make_unit(stats):
	var instance = UnitClass.instance()
	get_tree().get_root().get_node("Main").add_child(instance)
	instance.stats = stats
	instance.hp = stats.hit_points
	return instance
func _on_selected_from_list(index):
	if(!item_list.is_item_disabled(index)):
		if(to_be_positioned != null):
			deselect()
		select(index)

func _on_ItemList_mouse_exited():
	input.allowed_to_cast = true
	
func _on_ItemList_mouse_entered():
	input.allowed_to_cast = false
	
func deselect():
	to_be_positioned.free()
	to_be_positioned_index = -1
func deactivate():
	item_list.set_item_disabled(to_be_positioned_index, true)
	item_list.unselect( to_be_positioned_index)
	to_be_positioned = null
	to_be_positioned_index = -1
func reactivate(index):
	item_list.set_item_disabled(index, false )
func select(index):
	to_be_positioned_index = index
	to_be_positioned =  make_unit(PlayerData.available_units[index])