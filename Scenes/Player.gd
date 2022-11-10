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
onready var Energybar = $"../CanvasLayer/Interface/Bars/EnergyBar/TextureProgress"
var sprinting = false;
var motion = Vector2();
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

enum GroundItem{
	CORN,
	APPLETREE,
	RASPBERRY,
	REDONION,
	PURPSHROOM,
	BLUEBERRY
}

var last_direction = Direction.DOWN;

func _ready():
	pass;


func pickUpGroundItem(a, b, c, d, e, f, groundItem):
	if ((position.x <= a and position.x >= b) and (position.y <= c and position.y >= d)):
		if Tiles.get_cell(e,f) != -1:
			if Input.is_action_just_pressed("press_enter"):
				Tiles.set_cell(e, f, -1)
				if (groundItem == GroundItem.CORN):
					acquiredCount.Corn += 1;
				elif (groundItem == GroundItem.APPLETREE):
					acquiredCount.AppleTree += 1;
				elif (groundItem == GroundItem.RASPBERRY):
					acquiredCount.RaspBerry += 1;
				elif (groundItem == GroundItem.REDONION):
					acquiredCount.RedOnion += 1;
				elif (groundItem == GroundItem.PURPSHROOM):
					acquiredCount.PurpShroom += 1;
				elif (groundItem == GroundItem.BLUEBERRY):
					acquiredCount.BlueBerry += 1;
				
#	if ((position.x <= 225 and position.x >= 205) and (position.y <= 340 and position.y >= 315)):
#	if Tiles.get_cell(13,20) != -1:
#		if Input.is_action_just_pressed("press_enter"):
#			Tiles.set_cell(13, 20, -1)
#			acquiredCount.Corn += 1


func _physics_process(delta): 
	
	
			
	
	motion.x = lerp(motion.x, 0, 0.2);
	motion.y = lerp(motion.y, 0, 0.2);
	motion.y = clamp(motion.y, -MAXSPEED, MAXSPEED);
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED);
	
	if get_tree().get_current_scene().get_name() == "StartScreen":
		if Input.is_action_pressed("sprint") and !dashing and startDash == -1:
			ACCEL = 210
			startDash = 2
		
			
	
	if(get_tree().get_current_scene().get_name() == "Main"):
		
		#print("x: " + str(position.x) + ", y: " + str(position.y))
	#print position
		
		if Input.is_action_pressed("sprint") and !dashing and startDash == -1:
			if Energybar.value >= 20:
				ACCEL = 210
				startDash = 2
				Energybar.value -= 20
		#middle corn
		pickUpGroundItem(225, 205, 340, 315, 13, 20, GroundItem.CORN);
		#left corn
		pickUpGroundItem(192, 172, 337, 317, 11, 20, GroundItem.CORN);
		#right corn
		pickUpGroundItem(257, 237, 304, 284, 15, 18, GroundItem.CORN);
		#leftappletree
		pickUpGroundItem(137, 117, 225, 205, 7, 12, GroundItem.APPLETREE);
		#rightappletree
		pickUpGroundItem(537, 517, 95, 75, 32, 4, GroundItem.APPLETREE);
		#leftraspberry
		pickUpGroundItem(209, 189, 308, 288, 12, 18, GroundItem.APPLETREE);
		#rightraspberry
		pickUpGroundItem(271, 251, 320, 300, 16, 19, GroundItem.APPLETREE);
		#leftRedMush
		pickUpGroundItem(437, 417, 210, 190, 26, 12, GroundItem.REDONION);
		#rightRedMush
		pickUpGroundItem(496, 476, 182, 172, 30, 11, GroundItem.REDONION);
		#PurpShroom
		pickUpGroundItem(161, 141, 256, 236, 9, 15, GroundItem.PURPSHROOM);
		#Blue1
		pickUpGroundItem(145, 125, 305, 285, 8, 18, GroundItem.BLUEBERRY);
		#Blue2
		pickUpGroundItem(561, 541, 206, 186, 34, 12, GroundItem.BLUEBERRY);
		#Blue3
		pickUpGroundItem(579, 559, 224, 204, 35, 13, GroundItem.BLUEBERRY);
		
		
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
	
	

	
	
	
	
	
		
		
