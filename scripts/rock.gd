extends CharacterBody2D

var left_limit = Vector2(0, 0)
var right_limit = Vector2(481, 0)
var move_speed = 400
var direction = 1
var start_position: Vector2
var is_movable = true

@onready var ani = $AnimatedSprite2D

func _ready():
	ani.play("idle")
	start_position = self.position

func _physics_process(delta):
	# stay after colliding
	if not is_movable:
		return
	
	position.x += direction * move_speed * delta
	
	# Reverse direction when reaching limits
	if position.x > start_position.x + right_limit.x:
		ani.play("right_hit")
		position.x = start_position.x + right_limit.x
		direction = -1
		is_movable = false
		$latency.start()
	elif position.x < start_position.x + left_limit.x:
		ani.play("left_hit")
		position.x = start_position.x + left_limit.x
		direction = 1
		is_movable = false
		$latency.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	ani.play("idle")
	pass # Replace with function body.


func _on_latency_timeout() -> void:
	is_movable = true
	pass # Replace with function body.
