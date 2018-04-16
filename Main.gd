extends Spatial

var angle = 0

func _process(delta):
	angle += delta;
	
	$TestCube.transform.basis = Basis(Vector3(0.5, 0.25, 0.1).normalized(), angle)

func _ready():
	$HSlider.value = $Worley_texture.max_distance * 100.0

func _on_HSlider_value_changed(value):
	$Worley_texture.max_distance = value / 100.0
