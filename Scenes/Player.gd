extends KinematicBody2D

const EPSILON = 1
const MAXSPEED = 210;
var ACCEL = 10;
var dashing = false
var startDash = -1;
var dashingCounter = 0;

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
	pass;

func _physics_process(delta): 
	
	motion.x = lerp(motion.x, 0, 0.2);
	motion.y = lerp(motion.y, 0, 0.2);
	motion.y = clamp(motion.y, -MAXSPEED, MAXSPEED);
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED);
	
	if Input.is_action_pressed("sprint") and !dashing and startDash == -1:
		ACCEL = 210
		startDash = 2
	
	if(get_tree().get_current_scene().get_name() == "Main"):
		if ($"../CanvasLayer/Interface/Bars/LifeBar/TextureProgress".value <= 0):
			get_tree().change_scene("res://Scenes/GameOver.tscn")
	
	if !dashing:
		if Input.is_action_pressed("right"):
			motion.x += ACCEL
		if Input.is_action_pressed("left"):
			motion.x += -ACCEL
		if Input.is_action_pressed("down"):
			motion.y += ACCEL
		if Input.is_action_pressed("up"):
			motion.y += -ACCEL
			
		if startDash > 0:
			startDash -= 1;
		elif startDash == 0:
			dashing = true;
			startDash = -1;
	else:
		dashingCounter += delta;
		if(dashingCounter > 0.3):
			dashing = false;
			ACCEL = 15;
			dashingCounter = 0;
	
	
	# Animate in the direction that our velocity is pointing
	# nice usage of EPSILON to make the movement animation smoother (:
	if motion.x > EPSILON:
		$AnimationPlayer.play("walk_right");
		last_direction = Direction.RIGHT;
	elif motion.x < EPSILON * -1:
		$AnimationPlayer.play("walk_left");
		last_direction = Direction.LEFT;
	elif motion.y > EPSILON:
		$AnimationPlayer.play("walk_down");
		last_direction = Direction.DOWN;
	elif motion.y < EPSILON * -1: 
		$AnimationPlayer.play("walk_up");
		last_direction = Direction.UP;
	
	# If we're not moving, stop the animation
	if motion.length() < EPSILON:
		if last_direction == Direction.RIGHT:
			$AnimationPlayer.play("idle_right");
		elif last_direction == Direction.LEFT:
			$AnimationPlayer.play("idle_left");
		elif last_direction == Direction.DOWN:
			$AnimationPlayer.play("idle_down");
		elif last_direction == Direction.UP:
			$AnimationPlayer.play("idle_up");
	
	
	
	motion = move_and_slide(motion * delta * 60)
