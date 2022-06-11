extends KinematicBody2D



var motion = Vector2();
var randomMotion = 0;

var detectionRadius = 100; # the pixel size of the detection radius of the cow.
var timeTillDash = 0;
var secondsToDash = 6;

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
	
	
	var tempx = abs(($"../Player").position.x - position.x)
	var tempy = abs(($"../Player").position.y - position.y)
	
	if((tempx*tempx + tempy*tempy) < detectionRadius*detectionRadius):
		timeTillDash += delta
		
		if (timeTillDash > secondsToDash):
			motion = direction * 3 * delta
			if timeTillDash > secondsToDash + 0.5:
				timeTillDash = 0
		
		position += motion
		#print((tempx*tempx + tempy*tempy))
		#print(detectionRadius*detectionRadius)
	
