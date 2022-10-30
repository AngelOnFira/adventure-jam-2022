extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Apple = 9
var BlueBerry = 9
var Corn = 9
var PurpleMush = 9
var Rasp = 9
var RedMush = 9



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	$"AppleTreeCounter/Label".text = str(Apple)
	$"BlueBerryCounter/Label".text = str(BlueBerry)
	$"CornCounter/Label".text = str(Corn)
	$"PurpleMushroomCounter/Label".text = str(PurpleMush)
	$"RaspberryCounter/Label".text = str(Rasp)
	$"RedMushroomCounter/Label".text = str(RedMush)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
