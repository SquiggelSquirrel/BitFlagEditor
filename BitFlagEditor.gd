extends EditorProperty

var outer = VBoxContainer.new()
var current_value = 0
var updating = false

var styleNormal = StyleBoxFlat.new()
var stylePressed = StyleBoxFlat.new()
var styleEmpty = StyleBoxEmpty.new()


func _init():
	styleNormal.bg_color = Color.dimgray
	stylePressed.bg_color = Color.lightgray
	
	add_child(outer)
	set_bottom_editor(outer)
	
	for row_index in 2:
		var row = HBoxContainer.new()
		outer.add_child(row)
		
		for i in 8:
			var bit = (row_index * 8) + i
			var button := Button.new()
			row.add_child(button)
			button.text = String(bit).pad_zeros(2)
			button.toggle_mode = true
			button.connect("toggled", self, "_on_button_toggled", [bit])
			button.add_stylebox_override("normal", styleNormal)
			button.add_stylebox_override("hover", styleNormal)
			button.add_stylebox_override("focus", styleEmpty)
			button.add_stylebox_override("pressed", stylePressed)
			button.add_color_override("font_color_pressed", Color.dimgray)
	
	refresh_button_states()


func update_property():
	var new_value = get_edited_object()[get_edited_property()]
	if (new_value == current_value):
		return
	
	updating = true
	current_value = new_value
	refresh_button_states()
	updating = false


func _on_button_toggled(is_pressed, bit):
	if (updating):
		return
	
	if is_pressed:
		current_value |= 1 << bit
	else:
		current_value &= ~ (1 << bit)
	
	emit_changed(get_edited_property(), current_value)


func refresh_button_states():
	var object = get_edited_object()
	var tooltips := []
	if (
			object
			and object.get_script()
			and object.get_script().is_tool()
			and object.has_method("_get_layer_names")
	):
		tooltips = object.call("_get_layer_names", get_edited_property())
	
	for row_index in 2:
		var row = outer.get_child(row_index)
		
		for i in 8:
			var bit = (row_index * 8) + i
			var button = row.get_child(i)
			button.pressed = current_value & 1 << bit
			
			if bit < tooltips.size():
				button.hint_tooltip = tooltips[bit]
