extends Spatial

var angle = 0

func _process(delta):
	angle += delta;
	
	# $TestCube.transform.basis = Basis(Vector3(0.5, 0.25, 0.1).normalized(), angle)

func _ready():
	$max_distance.value = $Worley_texture.max_distance * 100.0
	$cloud_density.value = $TestCube.get_surface_material(0).get_shader_param("cloud_density_factor")
	$light_density.value = $TestCube.get_surface_material(0).get_shader_param("light_density_factor")

func _on_max_distance_value_changed(value):
	$Worley_texture.max_distance = value / 100.01

func _on_cloud_density_value_changed(value):
	$TestCube.get_surface_material(0).set_shader_param("cloud_density_factor", value)

func _on_light_density_value_changed(value):
	$TestCube.get_surface_material(0).set_shader_param("light_density_factor", value)
