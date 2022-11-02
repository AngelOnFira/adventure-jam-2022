extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var num = 0
onready var TextureProgress = $"TextureProgress"
#onready var timer = yield(get_tree().create_timer(2.0), "timeout")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if TextureProgress.value < 100:
		num += 1
		if num % 20 == 0:
		#yield(get_tree().create_timer(1.0), "timeout")
			TextureProgress.value += 0.5
		#yield(get_tree().create_timer(1.0), "timeout")
		#_process(delta)
	

	
	
