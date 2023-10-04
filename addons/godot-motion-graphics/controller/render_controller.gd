@tool
extends Node

var _renderables:Dictionary= {}

func control(renderable:GmgRenderable):
	_renderables[renderable]=renderable.mesh

func release(renderable:GmgRenderable):
	_renderables.erase(renderable)
