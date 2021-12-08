shader_type canvas_item;
render_mode unshaded;

uniform vec3 texture_size = vec3(128.0, 128.0, 1.0);
uniform float max_distance = 0.5;

// Godot doesn't seem to have uniform arrays so we go the icky route...
uniform vec3 worley_point_01 = vec3(0.2, 0.4, 0.5);
uniform vec3 worley_point_02 = vec3(0.3, 0.1, 0.8);
uniform vec3 worley_point_03 = vec3(0.8, 0.6, 0.3);
uniform vec3 worley_point_04 = vec3(0.7, 0.3, 0.4);
uniform vec3 worley_point_05 = vec3(0.5, 0.9, 0.6);
uniform vec3 worley_point_06 = vec3(0.5, 0.9, 0.7);
uniform vec3 worley_point_07 = vec3(0.9, 0.3, 0.4);
uniform vec3 worley_point_08 = vec3(0.6, 0.4, 0.7);
uniform vec3 worley_point_09 = vec3(0.3, 0.7, 0.2);
uniform vec3 worley_point_10 = vec3(0.1, 0.4, 0.1);
uniform vec3 worley_point_11 = vec3(0.4, 0.2, 0.4);
uniform vec3 worley_point_12 = vec3(0.1, 0.5, 0.7);
uniform vec3 worley_point_13 = vec3(0.3, 0.3, 0.2);
uniform vec3 worley_point_14 = vec3(0.8, 0.1, 0.4);
uniform vec3 worley_point_15 = vec3(0.2, 0.9, 0.8);

float worley_dist(vec3 pos, vec3 worley_point, float p_max) {
	float value = p_max;
	
	for (float z = -1.0; z < 1.5; z += 1.0) {
		for (float y = -1.0; y < 1.5; y += 1.0) {
			for (float x = -1.0; x < 1.5; x += 1.0) {
				vec3 delta = worley_point - pos + vec3(x, y, z);
				float distance = length(delta);
				if (distance < value) {
					value = distance;
				}
			}
		}
	}
	
	return value;
}

float worley_value(vec3 pos) {
	float value = max_distance;
	vec3 fpos = mod(pos, 1.0);
	value = worley_dist(fpos, worley_point_01, value);
	value = worley_dist(fpos, worley_point_02, value);
	value = worley_dist(fpos, worley_point_03, value);
	value = worley_dist(fpos, worley_point_04, value);
	value = worley_dist(fpos, worley_point_05, value);
	value = worley_dist(fpos, worley_point_06, value);
	value = worley_dist(fpos, worley_point_07, value);
	value = worley_dist(fpos, worley_point_08, value);
	value = worley_dist(fpos, worley_point_09, value);
	value = worley_dist(fpos, worley_point_10, value);
	
	return clamp(value / max_distance, 0.0, 1.0);
}

void fragment() {
	float z = floor(UV.y * texture_size.z);
	float y = (UV.y * texture_size.z) - z;
	vec3 pos = vec3(UV.x, y, z / texture_size.z);
	vec4 result = vec4(0.0, 0.0, 0.0, 1.0);
	
	result.x = worley_value(pos); // octave 1
	result.y = worley_value(pos * 2.0); // octave 2
	result.z = worley_value(pos * 4.0); // octave 4
//	result.a = worley_value(pos * 8.0); // octave 8
	
	COLOR = result;
}