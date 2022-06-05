extends KinematicBody2D

const UP = Vector2(0,-1);
const MAXSPEED = 90;
const MAXSPRINTSPEED = 150;
var ACCEL = 15;

var facing_right = true;

var sprinting = false;
var motion = Vector2();

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var last_direction = Direction.DOWN;

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

	print(motion)

	# Animate in the direction that our velocity is pointing
	if motion.x > 0:
		$AnimationPlayer.play("walk_right");
		last_direction = Direction.RIGHT;
	elif motion.x < 0:
		$AnimationPlayer.play("walk_left");
		last_direction = Direction.LEFT;
	elif motion.y > 0:
		$AnimationPlayer.play("walk_down");
		last_direction = Direction.DOWN;
	elif motion.y < 0:
		$AnimationPlayer.play("walk_up");
		last_direction = Direction.UP;

	# If we're not moving, stop the animation
	if motion.length() < 0.3:
		if last_direction == Direction.RIGHT:
			$AnimationPlayer.play("idle_right");
		elif last_direction == Direction.LEFT:
			$AnimationPlayer.play("idle_left");
		elif last_direction == Direction.DOWN:
			$AnimationPlayer.play("idle_down");
		elif last_direction == Direction.UP:
			$AnimationPlayer.play("idle_up");

	
	motion = move_and_slide(motion * delta * 60)
