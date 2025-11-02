extends CharacterBody2D

var left_limit = Vector2(-140, 0)
var right_limit = Vector2(140, 0)
var move_speed = 80

var direction = 1
var start_position: Vector2

func _ready():
	start_position = self.position

func _physics_process(delta):
	position.x += direction * move_speed * delta
	
	# Reverse direction when reaching limits
	if position.x > start_position.x + right_limit.x:
		position.x = start_position.x + right_limit.x
		direction = -1
	elif position.x < start_position.x + left_limit.x:
		position.x = start_position.x + left_limit.x
		direction = 1
