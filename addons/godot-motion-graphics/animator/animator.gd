class_name GmgAnimator
extends Node

@export var pause_in_editor:bool = false

var _should_run:bool:
	get:
		return not(Engine.is_editor_hint() and pause_in_editor)


