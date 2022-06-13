extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta): 
	#$Player.motion.x += 100;
	#$Player/Boat.motion.x += $Player.ACCEL;
	if($Boat.position.x < 100):
		$Boat.position.x += 1;
	if($Boat.position.x > 90):
		$Boat/ex.visible = true;
		$Boat/ex1.visible = true;
		$Boat/ex2.visible = true;
		$Boat/ex3.visible = true;
		$Boat/ex4.visible = true;
		$Boat/ex5.visible = true;
		$Boat/ex6.visible = true;
		
	if($CutscenePlayer.position.x < -5):
		$CutscenePlayer.position.x += 1;
	else:
		get_tree().change_scene("res://Scenes/Main.tscn");
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
