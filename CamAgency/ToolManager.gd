extends PanelContainer

export(NodePath) onready var room_tool_button = get_node(room_tool_button)
var land

func on_zone_selected(start_cell, end_cell):
	if room_tool_button.pressed:
		land.add_room(start_cell, end_cell)
