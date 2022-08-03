extends EditorInspectorPlugin

var BitFlagEditor = preload("res://addons/BitFlags/BitFlagEditor.gd")


func can_handle(object):
	return true


func parse_property(object, type, path, hint, hint_text, usage):
	if type == TYPE_INT and hint == PROPERTY_HINT_FLAGS and ! hint_text:
		add_property_editor(path, BitFlagEditor.new())
		return true
	return false
