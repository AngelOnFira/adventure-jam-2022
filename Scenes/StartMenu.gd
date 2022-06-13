extends Node2D

var selected_menu = -1

func change_menu_color():
	$NewGame.color = Color.gray
	#$LoadGame.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$NewGame.color = Color.greenyellow
		1:
			$Quit.color = Color.greenyellow

func _ready():
	change_menu_color()

func _input(event):
	#if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("down"):
	#if $Quit.get_world_2d().direct_space_state.intersect_point($Player.position, 32, [], 2147483647, true, true):
	if ($Quit.rect_position + $Quit.rect_size/2).distance_to($Player.position) < 20:
		selected_menu = 1;
		change_menu_color()
		$Enter.visible = true;
		$Spacebar.visible = true;
	elif ($NewGame.rect_position + $NewGame.rect_size/2).distance_to($Player.position) < 20:
		selected_menu = 0;
		change_menu_color()
		$Enter.visible = true;
		$Spacebar.visible = true;
	else:
		selected_menu = -1;
		change_menu_color()
		$Enter.visible = false;
		$Spacebar.visible = false;
		
	if Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				# New game
				#get_tree().change_scene("res://Scenes/Main.tscn")
				get_tree().change_scene("res://Scenes/Cutscene.tscn")
			1:
				# Quit game
				get_tree().quit()

#	elif Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("up"):
#		if selected_menu > 0:
#			selected_menu = selected_menu - 1
#		else:
#			selected_menu = 2
#		change_menu_color()
#	elif Input.is_action_just_pressed("ui_accept"):
#		match selected_menu:
#			0:
#				# New game
#				get_tree().change_scene("res://Scenes/Main.tscn")
#			1:
#				# Load game
#				#var next_level_resource = load("res://Scenes/Main.tscn");
#				#var next_level = next_level_resource.instance()
#				#next_level.load_saved_game = true
#				#get_tree().root.call_deferred("add_child", next_level)
#				#queue_free()
#				pass
#			2:
#				# Quit game
#				get_tree().quit()
