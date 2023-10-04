shader_type particles;
render_mode disable_velocity, disable_force;

uniform vec2 grid_size;
uniform vec2 grid_spacing;
uniform float rotation_radians;
uniform vec2 scale;


void process() {
	// lay out the particles in a grid, according to the grid size and spacing
	// the grid is centered at the origin, and we get the current particle index
	// from INDEX
	
	// the grid is 2D, so we need to convert the 1D index to 2D
	// we do this by dividing the index by the grid size, and using the remainder
	// as the x coordinate, and the quotient as the y coordinate
	float grid_row = floor(float(INDEX) / grid_size.x);
	float grid_col = float(INDEX) - (grid_row * grid_size.x);
	
	// rotate around z axis
	TRANSFORM[0].x = cos(rotation_radians) * scale.x;
	TRANSFORM[0].y = sin(rotation_radians) * scale.y;
	TRANSFORM[1].x = -sin(rotation_radians);
	TRANSFORM[1].y = cos(rotation_radians);


	TRANSFORM[3].xyz = vec3(grid_col * grid_spacing.x, grid_row * grid_spacing.y, 0.0) 
		- vec3((grid_size.x - 1.) * grid_spacing.x, (grid_size.y - 1.) * grid_spacing.y, 0.0) / 2.0;
}
