extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Apple = 0
var BlueBerry = 0
var Corn = 0
var PurpleMush = 0
var Rasp = 0
var RedMush = 0



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
