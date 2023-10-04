@tool
class_name GmgGrid2D
extends GmgComposite

var _particle_systems:Array = []
var _materials:Array = []

@export_node_path("GmgRenderable") var source:NodePath:
	set(value):
		source = value
		_mark_dirty()

@export var grid_size:Vector2i:
	set(value):
		grid_size = value
		_mark_dirty()

@export var grid_spacing:Vector2:
	set(value):
		grid_spacing = value
		_mark_dirty()

@export_range(0,360) var item_rotation:float:
	set(value):
		item_rotation = value
		_mark_dirty()

@export var item_scale:Vector2:
	set(value):
		item_scale = value
		_mark_dirty()


func _ensure_particle_systems(count:int):
	while _particle_systems.size() < count:
		print("adding particles")

		var material = ShaderMaterial.new()
		material.set_shader(preload("grid2d.gdshader"))
		_materials.append(material)

		var ps = RenderingServer.particles_create()
		RenderingServer.particles_set_mode(ps, RenderingServer.PARTICLES_MODE_2D)
		RenderingServer.particles_set_draw_passes(ps, 1)
		RenderingServer.particles_set_process_material(ps, material.get_rid())
		RenderingServer.particles_set_amount(ps, grid_size.x * grid_size.y)
		RenderingServer.particles_set_explosiveness_ratio(ps, 1.0)
		RenderingServer.particles_set_randomness_ratio(ps, 0)
		RenderingServer.particles_set_lifetime(ps, 1000000)
		RenderingServer.particles_set_emitting(ps, true)
		_particle_systems.append(ps)

	while _particle_systems.size() > count:
		print("removing particles")
		var ps = _particle_systems.pop_back()
		RenderingServer.free_rid(ps)

		# is refcounted, so we don't need to free it
		_materials.pop_back()


func _repaint():
	# print("repaint")
	RenderingServer.canvas_item_clear(get_canvas_item())

	var source_node = get_node_or_null(source)
	if source_node == null:
		print("no source node")
		_ensure_particle_systems(0)
		return


	var meshes = source_node.meshes()
	_ensure_particle_systems(meshes.size())

	for i in range(meshes.size()):
		var mesh = meshes[i]
		var ps = _particle_systems[i]
		var material = _materials[i]

		material.set_shader_parameter("grid_size", grid_size)
		material.set_shader_parameter("grid_spacing", grid_spacing)
		material.set_shader_parameter("rotation_radians", deg_to_rad(item_rotation))
		material.set_shader_parameter("scale", item_scale)

		var aabb = AABB()
		aabb.position.x = -(grid_size.x -1) * grid_spacing.x / 2.0
		aabb.position.y = -(grid_size.y -1) * grid_spacing.y / 2.0
		aabb.size.x = grid_size.x * grid_spacing.x
		aabb.size.y = grid_size.y * grid_spacing.y

		RenderingServer.particles_set_custom_aabb(ps, aabb)
		RenderingServer.particles_set_amount(ps, grid_size.x * grid_size.y)
		RenderingServer.particles_set_draw_pass_mesh(ps, 0, mesh)
		RenderingServer.canvas_item_add_particles(get_canvas_item(), ps, RID())





func _notification(what):
	match what:
		NOTIFICATION_PREDELETE:
			_ensure_particle_systems(0)
				
