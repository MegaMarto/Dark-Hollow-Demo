extends Node3D

const speed = 10

var FireExplosion = preload("res://Spells/Fire/FireExplosion.tscn")
var FireExplosionInst
@onready var explosionposition = $StaticBody3D
@onready var collider = $StaticBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#fireball movement
func _process(delta):
	position += transform.basis * Vector3(0,0, -speed) * delta
	await get_tree().create_timer(5).timeout
	$".".queue_free()

	
		
		#var FireExplosionInst = FireExplosion.Instantiate
		#FireExplosionInst.position = explosionposition.global_position
		#FireExplosionInst.transform.basis = explosionposition.transform.basis
		#get_parent().add_child(FireExplosionInst)


func _on_area_3d_area_entered(area):
	#if statement checks if object is detectable by player's projectile
	#make sure target object has an area3d node thats in this group
	if area.is_in_group("PlayerTarget"):
		var FireExplosionInst = FireExplosion.instantiate()
		FireExplosionInst.position = explosionposition.global_position
		FireExplosionInst.transform.basis = explosionposition.transform.basis
		get_parent().add_child(FireExplosionInst)
		#delete self, for the reference drag the parent note
		$".".queue_free()
