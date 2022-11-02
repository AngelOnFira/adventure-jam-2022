extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Apple = 2
var BlueBerry = 3
var Corn = 3
var PurpleMush = 1
var Rasp = 2
var RedMush = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$"AppleTreeCounter/Label".text = str(Apple)
	$"BlueBerryCounter/Label".text = str(BlueBerry)
	$"CornCounter/Label".text = str(Corn)
	$"PurpleMushroomCounter/Label".text = str(PurpleMush)
	$"RaspberryCounter/Label".text = str(Rasp)
	$"RedMushroomCounter/Label".text = str(RedMush)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
