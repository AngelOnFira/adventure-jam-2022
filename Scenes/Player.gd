extends KinematicBody2D

export(float) var move_speed = 50

const UP = Vector2(0,-1);
const MAXSPEED = 90;
const MAXSPRINTSPEED = 150;
var ACCEL = 15;

var facing_right = true;

var sprinting = false;
var motion = Vector2();

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	pass

func _physics_process(delta): 
	#code for animation 
	var move_input = get_directional_input()
	
	print(move_input)
	
	
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
		state_machine.travel("walk_right")
	else:
		state_machine.travel("idle_right")
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


#animation code 
func get_directional_input():
	var move_input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	return move_input_vector
