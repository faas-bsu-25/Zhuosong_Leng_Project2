extends RigidBody2D

@onready var ani = $AnimatedSprite2D


func _ready() -> void:
	$fire_area/CollisionShape2D.disabled = true
	ani.play("fire_off")


func _on_fire_latency_timeout() -> void:
	ani.play("fire_on")
	$fire_off_latency.start()
	$fire_area/CollisionShape2D.disabled = false
	pass # Replace with function body.


func _on_fire_area_body_entered(body: CharacterBody2D) -> void:
	body.get_hurt()
	pass # Replace with function body.


func _on_fire_off_latency_timeout() -> void:
	$fire_area/CollisionShape2D.disabled = true
	ani.play("fire_off")
	pass # Replace with function body.


func _on_triggger_area_body_entered(body: CharacterBody2D) -> void:
	$fire_on_latency.start()
	ani.play("step_on")
	pass # Replace with function body.
