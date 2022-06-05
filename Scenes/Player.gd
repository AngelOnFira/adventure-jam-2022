extends KinematicBody2D

const UP = Vector2(0,-1);
const MAXSPEED = 90;
const MAXSPRINTSPEED = 150;
var ACCEL = 15;

var facing_right = true;

var sprinting = false;
var motion = Vector2();

func _ready():
	pass 

func _physics_process(delta): 
	
	motion.x = lerp(motion.x, 0, 0.2);
	motion.y = lerp(motion.y, 0, 0.2);
	motion.y = clamp(motion.y, -MAXSPEED, MAXSPEED);
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED);
	
#	if facing_right:
#		$AnimatedSprite.scale.x = 1;
#	else:
#		$AnimatedSprite.scale.x = -1;
#
#	if !Input.is_action_pressed("right") && !Input.is_action_pressed("left") && !Input.is_action_pressed("down") && !Input.is_action_pressed("up"):
#		$AnimatedSprite.play("Idle");
#	else:
#		$AnimatedSprite.play("Run");
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true;
	if Input.is_action_pressed("left"):
		motion.x += -ACCEL
		facing_right = false;
	if Input.is_action_pressed("down"):
		motion.y += ACCEL
	if Input.is_action_pressed("up"):
		motion.y += -ACCEL
	
	if Input.is_action_pressed("sprint"):
		ACCEL = 80
	if Input.is_action_just_released("sprint"):
		ACCEL = 15;
	
	motion = move_and_slide(motion, motion)
