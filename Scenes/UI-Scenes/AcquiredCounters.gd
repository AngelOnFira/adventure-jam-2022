extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var AppleTree = 0
var BlueBerry = 0
var Corn = 0
var PurpShroom = 0
var RedShroom = 0
var RedOnion = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	$"AppleTreeCounter/Label".text = str(AppleTree)
	$"BlueBerryCounter/Label".text = str(BlueBerry)
	$"CornCounter/Label".text = str(Corn)
	$"PurpleMushroomCounter/Label".text = str(PurpShroom)
	$"RaspberryCounter/Label".text = str(RedShroom)
	$"RedMushroomCounter/Label".text = str(RedOnion)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
