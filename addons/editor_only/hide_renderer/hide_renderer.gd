@tool
extends EditorPlugin

const EDITOR_SETTING_HIDE_RENDERER_BUTTON := &"interface/editor/show_renderer_switch"
var renderer_button : Control = null
var initial_renderer_button_state : bool = false
var settings : EditorSettings = null


func _enter_tree():
	var node : Control = Control.new()
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, node)
	
	renderer_button = _search_for_renderer_button(node.get_parent())
	if renderer_button:
		settings = get_editor_interface().get_editor_settings()
		if settings:
			settings.settings_changed.connect(_update_visibility)
		
		initial_renderer_button_state = renderer_button.visible
		_add_editor_setting()
		_update_visibility()
	
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, node)
	node.queue_free()


func _exit_tree():
	if renderer_button:
		if settings:
			settings.settings_changed.disconnect(_update_visibility)
			settings = null
		
		renderer_button.visible = initial_renderer_button_state
		renderer_button = null


func _add_editor_setting():
	get_editor_interface().get_editor_settings()
	if !settings.has_setting(EDITOR_SETTING_HIDE_RENDERER_BUTTON):
		settings.set(EDITOR_SETTING_HIDE_RENDERER_BUTTON, false)
	
	var property_info = {
		"name": EDITOR_SETTING_HIDE_RENDERER_BUTTON,
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
	}
	
	settings.add_property_info(property_info)
	settings.set_initial_value(EDITOR_SETTING_HIDE_RENDERER_BUTTON, false, false)


func _update_visibility():
	if renderer_button:
		if settings.has_setting(EDITOR_SETTING_HIDE_RENDERER_BUTTON):
			renderer_button.visible = settings.get_setting(EDITOR_SETTING_HIDE_RENDERER_BUTTON)


func _search_for_renderer_button(root : Control) -> Control:
	for c in root.get_children():
		# first, the owner must be an HBoxContainer
		if c is HBoxContainer:
			for hc in c.get_children():
				# secondly, the child element must be an OptionButton
				var b := hc as OptionButton
				if b:
					# and finally, check the connection to &EditorNode::_renderer_selected
					# this is the most reliable information to get this button
					var con : Array = b.item_selected.get_connections()
					for col in con:
						var sig : Signal = col["signal"]
						var cal : Callable = col["callable"]
						if	sig.get_name() == &"item_selected"\
								and cal.get_method() == &"EditorNode::_renderer_selected":
							return b
	return null 
