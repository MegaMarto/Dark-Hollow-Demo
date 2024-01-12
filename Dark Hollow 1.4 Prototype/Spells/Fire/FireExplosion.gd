extends RigidBody3D

@onready var mesh = $MeshInstance3D
@onready var animation_player = $MeshInstance3D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_player.play("FireExplosion")
	#explosion growth and growth limit on mesh
	if(mesh.mesh.radius < 10 and mesh.mesh.height < 10):
		mesh.mesh.radius += 0.1
		mesh.mesh.height += 0.1
		await get_tree().create_timer(2).timeout
		#destroy object
		$".".queue_free()
		#reset size because godot...
		mesh.mesh.radius = 1
		mesh.mesh.height = 1

 
