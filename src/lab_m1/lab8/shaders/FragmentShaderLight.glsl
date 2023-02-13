#version 330

// TODO: get color value from vertex shader
in vec3 world_position;
in vec3 world_normal;

// Uniforms for light properties
uniform vec3 point_light_pos[2];
uniform vec3 point_light_dir[2];
uniform vec3 eye_position;

uniform float material_kd;
uniform float material_ks;
uniform int material_shininess;
uniform int is_spot;
uniform float angle;
uniform vec3 object_color;

out vec4 out_color;

void main()
{
	vec3 N = normalize(world_normal);
	vec3 L = normalize(point_light_pos[0] - world_position);
	vec3 V = normalize(eye_position - world_position);
	vec3 H = normalize(L + V);
	vec3 R = normalize(reflect (-L, N));

	// TODO: define ambient light component
	float ambient_light = 0.25 * material_kd;

	// TODO: compute diffuse light component
	float diffuse_light = material_kd * max(dot(N, L), 0);

	// TODO: compute specular light component
	float specular_light = 0;

	if (diffuse_light > 0)
	{
		specular_light = material_ks * pow(max(dot(V, R), 0), material_shininess);
	}

	// TODO: compute light
	float light1 = ambient_light;
	float cut_off = angle;
	float spot_light = dot(-L, point_light_dir[0]);
	float spot_light_limit = cos(cut_off);
	float dist = distance(point_light_pos[0], world_position);
	float factor_attenuation = 1 / (pow(dist, 2) + 1);
	
	if (is_spot == 1) {
		if (spot_light > spot_light_limit) {	 
			float linear_att = (spot_light - spot_light_limit) / (1.0f - spot_light_limit);
			float light_att_factor = pow(linear_att, 2);
			light1 = ambient_light + light_att_factor * (diffuse_light + specular_light);
		} 

	} else {
		light1 = ambient_light + factor_attenuation * (diffuse_light + specular_light);
	}
	
	N = normalize(world_normal);
	L = normalize(point_light_pos[1] - world_position);
	V = normalize(eye_position - world_position);
	H = normalize(L + V);
	R = normalize(reflect (-L, N));

	// TODO: define ambient light component
	ambient_light = 0.25 * material_kd;

	// TODO: compute diffuse light component
	diffuse_light = material_kd * max(dot(N, L), 0);

	// TODO: compute specular light component
	specular_light = 0;

	if (diffuse_light > 0)
	{
		specular_light = material_ks * pow(max(dot(V, R), 0), material_shininess);
	}

	// TODO: compute light
	float light2 = ambient_light;
	cut_off = angle;
	spot_light = dot(-L, point_light_dir[1]);
	spot_light_limit = cos(cut_off);
	dist = distance(point_light_pos[1], world_position);
	factor_attenuation = 1 / (pow(dist, 2) + 1);
	
	if (is_spot == 1) {
		if (spot_light > spot_light_limit) {	 
			float linear_att = (spot_light - spot_light_limit) / (1.0f - spot_light_limit);
			float light_att_factor = pow(linear_att, 2);
			light2 = ambient_light + light_att_factor * (diffuse_light + specular_light);
		} 

	} else {
		light2 = ambient_light + factor_attenuation * (diffuse_light + specular_light);
	}

	// TODO: write pixel out color
	vec3 colour = object_color * light1 + object_color * light2;

	out_color = vec4(colour, 1.f);
}