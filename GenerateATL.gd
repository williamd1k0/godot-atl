extends Node

const ShowATL = preload("res://ShowATL.tscn")
const Displayable = preload("res://Displayable.gd")

func _ready():
	var atl_list = generate_from_children()
	var showatl = ShowATL.instance()
	add_child(showatl)
	showatl.text = '# Godot / Ren\'Py ATL\n\n'
	for atl in atl_list:
		showatl.text += atl + '\n\n'
	OS.window_size = showatl.rect_size

func generate_from_children():
	var atl_list = []
	for c in get_children():
		if c is Displayable:
			atl_list.append(c.generate_atl())
		else:
			prints('WARN:', c, 'is not a Displayable!')
		c.queue_free()
	return atl_list
