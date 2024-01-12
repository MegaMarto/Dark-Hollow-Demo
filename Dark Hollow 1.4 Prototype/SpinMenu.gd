extends Control

##magic list
var magics = ["water", "fire", "wind"]

var spins = 5

#chosen magic to appear in one tick of the spinning (this isnt the final chosen magic)
var chosen_magic
var chosen_magic1
var chosen_magic2
var chosen_magic3
var chosen_magic4
var chosen_magic5
var chosen_magic6
var chosen_magic7
var chosen_magic8

var final_chosen_magic


func _on_button_pressed():
	if(spins > 0):
		spins -= 1
			#shuffles the list list
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic = magics[0]
		$LabelMagicShown.text = (chosen_magic)
		
		
		await get_tree().create_timer(0.4).timeout
		
	#shuffles the list 2nd
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic1 = magics[0]
		$LabelMagicShown.text = (chosen_magic1)
		
		
		await get_tree().create_timer(0.4).timeout
		
	#shuffles the list 3rd
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic2 = magics[0]
		$LabelMagicShown.text = (chosen_magic2)
		
		
		await get_tree().create_timer(0.4).timeout
		
		#shuffles the list 4th
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic3 = magics[0]
		$LabelMagicShown.text = (chosen_magic3)
		
		
		await get_tree().create_timer(0.5).timeout
		
		#shuffles the list 5th
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic4 = magics[0]
		$LabelMagicShown.text = (chosen_magic4)
		
		
		await get_tree().create_timer(0.5).timeout
		
		#shuffles the list 6th
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic5 = magics[0]
		$LabelMagicShown.text = (chosen_magic5)
		
		
		await get_tree().create_timer(0.6).timeout
		
		#shuffles the list 7th
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic6 = magics[0]
		$LabelMagicShown.text = (chosen_magic6)
		
		
		await get_tree().create_timer(0.7).timeout
		
		#shuffles the list 8th
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic7 = magics[0]
		$LabelMagicShown.text = (chosen_magic7)
		
		
		await get_tree().create_timer(0.8).timeout
		
		#shuffles the list 9th
		magics.shuffle()
		
		#chooses the first on the list
		var chosen_magic8 = magics[0]
		$LabelMagicShown.text = (chosen_magic8)
		
		
		await get_tree().create_timer(1).timeout
		
		#magic which the player gets
		magics.shuffle()
		
		var final_chosen_magic = magics[0]
		$LabelMagicShown.text = (final_chosen_magic)
		GlobalVariables.confirmed_chosen_magic = final_chosen_magic
		
		

#send user to main game
func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

#show spin amounts on label, idk why it wants it converted to a string
func _physics_process(delta):
	$LabelSpinsShown.text = str(spins)
