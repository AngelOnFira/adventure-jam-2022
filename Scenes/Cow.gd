extends KinematicBody2D




var motion = Vector2();
var randomMotion = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta): 
	#if(position != null):
	var direction = (($"../Player").position - position)
	direction.normalized()
	
	#print(($"../Player").position.x - position.x)
	
	if (($"../Player").position.x - position.x < 0 and scale.x != -1):
		$AnimatedSprite.scale.x = -1;
	else:
		$AnimatedSprite.scale.x = 1;
	
	
	draw_circle(direction, 0.4, Color.red)
	var motion = direction * 1/(randi()%5 + 1) * delta
	position += motion
	
	move_and_slide(motion * delta * 60);
	
