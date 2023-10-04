@tool
class_name GmgRangeAnimator
extends GmgAnimator

@export var min: float = 0.0
@export var max: float = 1.0
@export var time_scale: float = 1.0

var _value

@export var property:StringName = ""

func _ready():
	_value = get_parent().get(property)
	if _value == null:
		_value = min

func _process(delta):
	if not _should_run:
		return
		
	_value += delta * (max - min) / time_scale
	if _value > max:
		_value -= max - min
	
	get_parent().set(property, _value)
