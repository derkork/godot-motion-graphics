@tool
class_name GmgRectangle
extends GmgRenderable

var _mesh = QuadMesh.new()

@export var width: float:
	set(value):
		width = value
		_mark_dirty()

@export var height: float:
	set(value):
		height = value
		_mark_dirty()


func meshes() -> Array[RID]:
	return [_mesh.get_rid()]

func _repaint():
	_mesh.size = Vector2(width, height)
	RenderingServer.canvas_item_clear(get_canvas_item())
	RenderingServer.canvas_item_add_mesh(get_canvas_item(), _mesh.get_rid())
