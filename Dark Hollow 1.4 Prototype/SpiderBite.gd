extends Node3D

@onready var animation_player = $SLASH/Circle_001/AnimationPlayer
@onready var animation_player2 = $SLASH2/Circle_001/AnimationPlayer2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_player.play("Spiderbite")
	animation_player2.play("Spiderbite")
	await get_tree().create_timer(2).timeout
	$".".queue_free()
 
