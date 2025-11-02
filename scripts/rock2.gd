extends CharacterBody2D

var size = Vector2(434, 163)
var move_speed = 400
var direction = "right"
var start_position: Vector2
var is_movable = true
var is_vertical = false

@onready var ani = $AnimatedSprite2D

func _ready():
	ani.play("idle")
	start_position = self.position

func _physics_process(delta):
	# stay after colliding
	if not is_movable:
		return
	
	if direction == "right":
		position.x += move_speed * delta
		if position.x >= start_position.x + size.x:
			position.x = start_position.x + size.x
			direction = "up"
			stop_movement("right_hit")

	elif direction == "up":
		position.y -= move_speed * delta
		if position.y <= start_position.y - size.y:
			position.y = start_position.y - size.y
			direction = "left"
			stop_movement("top_hit")

	elif direction == "left":
		position.x -= move_speed * delta
		if position.x <= start_position.x:
			position.x = start_position.x
			direction = "down"
			stop_movement("left_hit")

	elif direction == "down":
		position.y += move_speed * delta
		if position.y >= start_position.y:
			position.y = start_position.y
			direction = "right"
			stop_movement("bottom_hit")


func stop_movement(animation: String):
	is_movable = false
	ani.play(animation)
	$latency.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	ani.play("idle")
	pass # Replace with function body.


func _on_latency_timeout() -> void:
	is_movable = true
	pass # Replace with function body.
