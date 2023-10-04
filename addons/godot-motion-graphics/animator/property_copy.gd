@tool
class_name GmgPropertyCopy
extends GmgAnimator

@export var source:NodePath
@export var source_property:StringName
@export var target_property:StringName

@export var triggered:bool = false


@onready var _source:Node = get_node_or_null(source)
@onready var _target:Node = get_parent()

func _ready():
	if triggered:
		set_process(false)

func _process(delta):
	copy()
	
func copy():	
	if not is_instance_valid(_source) or not _should_run:
		return
		
	_target.set(target_property, _source.get(source_property))
		
