extends RigidBody3D


@onready var player = $"../../player"

@onready var firepoint = $Firepoint

@onready var SpitCooldown = $"Timer(SpitCooldown)"
@onready var EggCooldown = $"Timer(EggCooldown)"

var Spit = preload("res://bigspiderspit.tscn")
var Egg = preload("res://spideregg.tscn")
var SpitInst
var EggInst


var detected

var health = 200

var stunned = false



func _on_area_3d_detection_body_entered(body):
	if body.is_in_group("Player"):
		detected = true



func _physics_process(delta):
	
	
	if detected == true:
		if !stunned:
			
			#look at player
			look_at(player.global_transform.origin,Vector3.UP)
			#prevent rotating upwards, can only rotate horizontally
			rotation.x = 0
			
			if SpitCooldown.is_stopped():
				var SpitInst = Spit.instantiate()
				SpitInst.position = firepoint.global_position
				SpitInst.transform.basis = firepoint.global_transform.basis
				get_parent().add_child(SpitInst)
				SpitCooldown.start()
				
			if EggCooldown.is_stopped():
				var EggInst = Egg.instantiate()
				EggInst.position = firepoint.global_position
				EggInst.transform.basis = firepoint.global_transform.basis
				get_parent().add_child(EggInst)
				EggCooldown.start()


func _on_area_3d_hitbox_area_entered(area):
	#damage modules
	if area.is_in_group("Fireball"):
		print("HISSS")
		health -= 40
		
	if area.is_in_group("WaterOrb"):
		stunned = true
		await get_tree().create_timer(2).timeout
		stunned = false
		health -= 20
	
	if area.is_in_group("WindBlade"):
		health -= 10
	
	if health <= 0:
		$".".queue_free()
