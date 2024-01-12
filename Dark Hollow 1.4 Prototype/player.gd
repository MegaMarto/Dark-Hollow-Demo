extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 10

var sens_horizontal = 0.5
var sens_vertical = 0.1
@onready var cameramount = $cameramount
@onready var animation_player = $"visuals/darkhollow player - animated/AnimationPlayer"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#keeps player frozen during spell
var isCasting = false

#additional spell related variables
@onready var firepoint1 = $Firepoint
@onready var FireballCooldown = $FireballCooldown
@onready var WaterOrbCooldown = $WaterOrbCooldown
@onready var WindBladeCooldown = $WindBladeCooldown

#spell list
var Fireball = preload("res://Spells/Fire/Fireball.tscn")
var FireballInst

var WaterOrb = preload("res://WaterOrb.tscn")
var WaterOrbInst

var WindBlade = preload("res://WindBlade.tscn")
var WindBlade2 = preload("res://WindBlade2.tscn")
var WindBladeInst
var WindBlade2Inst

var health = 100
var dmgreduction = 0

@onready var healthbar = $Control/HealthBar


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		cameramount.rotate_x(deg_to_rad(event.relative.y * sens_vertical))

func _physics_process(delta):
	#cooldown ui script
	if (GlobalVariables.confirmed_chosen_magic == "fire"):
		get_node("Control/FireballUiCD").visible = true
		get_node("Control/FireballUiCD/FireballCooldown").visible = true
		if !FireballCooldown.is_stopped():
			get_node("Control/FireballUiCD").visible = false
			get_node("Control/FireballUiCD/FireballCooldown").visible = false
		
	if (GlobalVariables.confirmed_chosen_magic == "water"):
		get_node("Control/WaterOrbUiCD").visible = true
		get_node("Control/WaterOrbUiCD/WaterOrbCooldown").visible = true
		if !WaterOrbCooldown.is_stopped():
			get_node("Control/WaterOrbUiCD").visible = false
			get_node("Control/WaterOrbUiCD/WaterOrbCooldown").visible = false
		
	if (GlobalVariables.confirmed_chosen_magic == "wind"):
		get_node("Control/WindBladeUiCD").visible = true
		get_node("Control/WindBladeUiCD/WindBladeCooldown").visible = true
		if !WindBladeCooldown.is_stopped():
			get_node("Control/WindBladeUiCD").visible = false
			get_node("Control/WindBladeUiCD/WindBladeCooldown").visible = false
	
	#SPELLS
	
	#Fireball
	if (GlobalVariables.confirmed_chosen_magic == "fire"):
		
		if !animation_player.is_playing():
			isCasting = false
		if Input.is_action_just_pressed("One") and FireballCooldown.is_stopped():
			if animation_player.current_animation != "LeftHandForward":
				FireballCooldown.start()
				animation_player.play("LeftHandForward")
				isCasting = true
			
			await get_tree().create_timer(0.8).timeout
			var FireballInst = Fireball.instantiate()
			FireballInst.position = firepoint1. global_position
			FireballInst.transform.basis = firepoint1.global_transform.basis
			get_parent().add_child(FireballInst)
		
	
	#Water Orb
	if (GlobalVariables.confirmed_chosen_magic == "water"):
		if !animation_player.is_playing():
			isCasting = false
		if Input.is_action_just_pressed("One") and WaterOrbCooldown.is_stopped():
			if animation_player.current_animation != "LeftHandForward":
				WaterOrbCooldown.start()
				animation_player.play("LeftHandForward")
				isCasting = true
				
			await get_tree().create_timer(0.8).timeout
			var WaterOrbInst = WaterOrb.instantiate()
			WaterOrbInst.position = firepoint1.global_position
			WaterOrbInst.transform.basis = firepoint1.global_transform.basis
			get_parent().add_child(WaterOrbInst)
			
	#Wind Blade
	if (GlobalVariables.confirmed_chosen_magic == "wind"):
		if !animation_player.is_playing():
			isCasting = false
		if Input.is_action_just_pressed("One") and WindBladeCooldown.is_stopped():
			if animation_player.current_animation != "LeftHandForward":
				WindBladeCooldown.start()
				animation_player.play("LeftHandForward")
				isCasting = true
			
			await get_tree().create_timer(0.8).timeout
			var WindBladeInst = WindBlade.instantiate()
			WindBladeInst.position = firepoint1.global_position
			WindBladeInst.transform.basis = firepoint1.global_transform.basis
			get_parent().add_child(WindBladeInst)
			
			await get_tree().create_timer(0.8).timeout
			var WindBlade2Inst = WindBlade2.instantiate()
			WindBlade2Inst.position = firepoint1.global_position
			WindBlade2Inst.transform.basis = firepoint1.global_transform.basis
			get_parent().add_child(WindBlade2Inst)

	#MOVEMENT
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if !isCasting:
			if animation_player.current_animation != "Walking":
				animation_player.play("Walking")
			
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		if !isCasting:
			if animation_player.current_animation != "Idle":
				animation_player.play("Idle")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if !isCasting:
		move_and_slide()
		
	#health bar
	healthbar.value = health


#damage module
func _on_hitbox_area_entered(area):
	if area.is_in_group("Void"):
		health -= 200000
	
	if area.is_in_group("Spiderbite"):
		print("ow")
		health -= 20
	
	if area.is_in_group("BigSpiderSpit"):
		print("OW")
		health -= 45
		
		
	if health <= 0:
		#$".".queue_free()
		get_tree().quit()
