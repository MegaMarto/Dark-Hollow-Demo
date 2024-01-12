extends Node3D

const speed = 25




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#fireball movement
func _process(delta):
	position += transform.basis * Vector3(0,0, -speed) * delta
	await get_tree().create_timer(5).timeout
	$".".queue_free()
