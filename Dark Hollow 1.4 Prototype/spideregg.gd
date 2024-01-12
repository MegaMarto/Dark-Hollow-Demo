extends RigidBody3D

var Spider = preload("res://cavespider.tscn")
var SpiderInst

@onready var spawnpoint = $Spawnpoint

var detected



# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_force(Vector3(500, 0, 0))


func _on_area_3d_detection_body_entered(body):
	if body.is_in_group("Player"):
		detected = true
		


func _process(delta):
	if detected == true:
		get_node("GPUParticles3D").visible = true
		await get_tree().create_timer(5).timeout
		var SpiderInst = Spider.instantiate()
		SpiderInst.position = spawnpoint.global_position
		SpiderInst.transform.basis = spawnpoint.global_transform.basis
		get_parent().add_child(SpiderInst)
		$".".queue_free()
