@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("GmgRenderController", "res://addons/godotion-motion-graphics/controller/render_controller.gd")


func _exit_tree():
	remove_autoload_singleton("GmgRenderController")