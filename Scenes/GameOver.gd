extends Node2D


var selected_menu = -1;

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
	if event is InputEventMouseButton:
		#$Quit.rect_size
		if ($Quit.rect_position.x).distance_to(event.global_position) < 20:
			get_tree().quit()
		if ($NewGame.rect_position + $NewGame.rect_size/2).distance_to(event.global_position) < 20:
			get_tree().change_scene("res://Scenes/StartMenu.tscn")
	elif event is InputEventMouseMotion:
		if ($Quit.rect_position + $Quit.rect_size/2).distance_to(event.global_position) < 20:
			#print("Mouse Motion at: ", event.position)
			$Quit.color = Color.white
		else:
			$Quit.color = Color.gray
			
		if ($NewGame.rect_position + $NewGame.rect_size/2).distance_to(event.global_position) < 20:
			#print("Mouse Motion at: ", event.position)
			$NewGame.color = Color.white
		else:
			$NewGame.color = Color.gray
