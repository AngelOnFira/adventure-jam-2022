extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var AppleTree = 2
var BlueBerry = 3
var Corn = 3
var PurpShroom = 1
var RedShroom = 2
var RedOnion = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$"AppleTreeCounter/Label".text = str(AppleTree)
	$"BlueBerryCounter/Label".text = str(BlueBerry)
	$"CornCounter/Label".text = str(Corn)
	$"PurpleMushroomCounter/Label".text = str(PurpShroom)
	$"RaspberryCounter/Label".text = str(RedShroom)
	$"RedMushroomCounter/Label".text = str(RedOnion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
