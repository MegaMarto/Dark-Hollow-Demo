extends Control




func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")



func _on_spin_pressed():
	get_tree().change_scene_to_file("res://SpinMenu.tscn")
