@tool
class_name GmgRenderable
extends Node2D

signal modified()

var _dirty = true

enum Anchor {
	TOP_LEFT = 0,
	TOP = 1,
	TOP_RIGHT = 2,
	LEFT = 3,
	CENTER = 4,
	RIGHT = 5,
	BOTTOM_LEFT = 6,
	BOTTOM = 7,
	BOTTOM_RIGHT = 8,
}

func _mark_dirty():
	_dirty = true


func _repaint():
	pass


func _ready():
	_repaint()

func _process(delta):
	if _dirty:
		_dirty = false
		modified.emit()
		_repaint()

## Returns the meshes that are required to render for this object.
func meshes() -> Array[RID]:
	return []

func calculate_relative_anchor_position(anchor: Anchor) -> Vector2:
	return Vector2.ZERO

