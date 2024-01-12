extends Node3D

var health = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_hitbox_area_entered(area):
	if area.is_in_group("Fireball"):
		print("splat")
		health -= 40
		
	if area.is_in_group("WaterOrb"):
		print("splat")
		health -= 40
	
	if area.is_in_group("WindBlade"):
		print("splat")
		health -= 40
	
	if health <= 0:
		$".".queue_free()
