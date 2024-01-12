extends RigidBody3D

@onready var animation_player = $"cave spider/AnimationPlayer"

@onready var player = $"../../player"

@onready var firepoint = $Firepoint

@onready var JumpCooldown = $JumpCooldown
@onready var BiteCooldown = $BiteCooldown

var SpiderBite = preload("res://SpiderBite.tscn")
var SpiderBiteInst

var speed = 6
var jump_strength = 10

var detected

var isAttacking = false

var health = 60

var stunned = false


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		detected = true


func _physics_process(delta):
	
	
	if detected == true:
		if !stunned:
			
			#look at player
			look_at(player.global_transform.origin,Vector3.UP)
			#prevent rotating upwards, can only rotate horizontally
			rotation.x = 0
			#go forward
			position += transform.basis * Vector3(0,0, -speed) * delta
			if !isAttacking:
				animation_player.play("SpiderWalk1")
			if JumpCooldown.is_stopped():
				_jumping()
				JumpCooldown.start()
				
			if !animation_player.is_playing():
				isAttacking = false
				
			if BiteCooldown.is_stopped():
				if animation_player.current_animation != "SpiderBite":
					isAttacking = true
				
				animation_player.play("SpiderMele1")
				var SpiderBiteInst = SpiderBite.instantiate()
				SpiderBiteInst.position = firepoint.global_position
				SpiderBiteInst.transform.basis = firepoint.global_transform.basis
				get_parent().add_child(SpiderBiteInst)
				BiteCooldown.start()
			
			


func _jumping():
	#jumping
	apply_central_force(Vector3(0, 500, 0))



#damage modules
func _on_hitbox_area_entered(area):
	if area.is_in_group("Fireball"):
		print("hiss")
		health -= 30
	
	if area.is_in_group("WaterOrb"):
		stunned = true
		await get_tree().create_timer(2).timeout
		stunned = false
		health -= 20
	
	if area.is_in_group("WindBlade"):
		health -= 10
	
	if health <= 0:
		$".".queue_free()
	
	
