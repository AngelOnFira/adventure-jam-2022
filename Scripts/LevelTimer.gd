extends Label

signal set_timer

var last_second = 0

func _ready():
	connect("set_timer", self, "set_timer")

	emit_signal("set_timer", 13)

func _process(delta):
	var second = int($Timer.time_left)

	# Set the text
	self.text = str(second)

	# Play the animation once a second while the timer is less than 10 seconds
	if second <= 10 and second != last_second:
		last_second = second

		# Update the pivot so the animation is in the middle
		self.rect_pivot_offset = Vector2(self.rect_size[0] / 2, self.rect_size[1] / 2)

		$AnimationPlayer.play("last_second_bounce")

func set_timer(seconds: float):
	last_second = -1
	$Timer.start(seconds)
