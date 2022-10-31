extends KinematicBody2D

const EPSILON = 1
const MAXSPEED = 210;
var ACCEL = 10;
var dashing = false
var startDash = -1;
var dashingCounter = 0;
onready var Tiles = $"../Plants" #onready (the value will change to the set value when the set value is initalized
#var Tiles = get_parent().get_node("Plants")
onready var acquiredCount = $"../CanvasLayer/Interface/AcquiredCounters"
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
	
	print("x: " + str(position.x) + ", y: " + str(position.y))
	#middle corn
	if ((position.x <= 225 and position.x >= 205) and (position.y <= 340 and position.y >= 315)):
		if Tiles.get_cell(13,20) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(13, 20, -1)
				acquiredCount.Corn += 1
	#left corn
	if ((position.x <= 192 and position.x >= 172) and (position.y <= 337 and position.y >= 317)):
		if Tiles.get_cell(11,20) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(11, 20, -1)
				acquiredCount.Corn += 1
	#right corn
	if ((position.x <= 257 and position.x >= 237) and (position.y <= 304 and position.y >= 284)):
		if Tiles.get_cell(15,18) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(15, 18, -1)
				acquiredCount.Corn += 1
	#leftappletree
	if ((position.x <= 137 and position.x >= 117) and (position.y <= 225 and position.y >= 205)):
		if Tiles.get_cell(7,12) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(7, 12, -1)
				acquiredCount.Apple += 1
	#rightappletree
	if ((position.x <= 537 and position.x >= 517) and (position.y <= 95 and position.y >= 75)):
		if Tiles.get_cell(32,4) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(32, 4, -1)
				acquiredCount.Apple += 1
	#leftraspberry
	if ((position.x <= 209 and position.x >= 189) and (position.y <= 308 and position.y >= 288)):
		if Tiles.get_cell(12,18) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(12, 18, -1)
				acquiredCount.Rasp += 1
	#rightraspberry
	if ((position.x <= 271 and position.x >= 251) and (position.y <= 320 and position.y >= 300)):
		if Tiles.get_cell(16,19) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(16, 19, -1)
				acquiredCount.Rasp += 1
	#leftRedMush
	if ((position.x <= 437 and position.x >= 417) and (position.y <= 210 and position.y >= 190)):
		if Tiles.get_cell(26,12) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(26, 12, -1)
				acquiredCount.RedMush += 1
	#rightRedMush
	if ((position.x <= 496 and position.x >= 476) and (position.y <= 182 and position.y >= 172)):
		if Tiles.get_cell(30,11) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(30, 11, -1)
				acquiredCount.RedMush += 1
	#PurpMush
	if ((position.x <= 161 and position.x >= 141) and (position.y <= 256 and position.y >= 236)):
		if Tiles.get_cell(9,15) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(9, 15, -1)
				acquiredCount.PurpleMush += 1
	#Blue1
	if ((position.x <= 145 and position.x >= 125) and (position.y <= 305 and position.y >= 285)):
		if Tiles.get_cell(8,18) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(8, 18, -1)
				acquiredCount.BlueBerry += 1
	#Blue2
	if ((position.x <= 561 and position.x >= 541) and (position.y <= 206 and position.y >= 186)):
		if Tiles.get_cell(34,12) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(34, 12, -1)
				acquiredCount.BlueBerry += 1
	#Blue3
	if ((position.x <= 579 and position.x >= 559) and (position.y <= 224 and position.y >= 204)):
		if Tiles.get_cell(35,13) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(35, 13, -1)
				acquiredCount.BlueBerry += 1
		
			
	
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
	
	

	
	
	
	
	
		
		
