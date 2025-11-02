extends Node2D

@export var ani: AnimatedSprite2D
var Vspeed = 0
var Hspeed = 0
var on_floor = true
var is_sliding = false
var is_hurt = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_hurt:
		ani.play("hurt")
		return
	
	if Vspeed < 0:
		ani.play("jump")
		if Hspeed > 0:
			ani.flip_h = false
		elif Hspeed < 0:
			ani.flip_h = true
	elif Vspeed > 0 and not is_sliding:
		ani.play("fall")
		if Hspeed > 0:
			ani.flip_h = false
		elif Hspeed < 0:
			ani.flip_h = true
	elif Hspeed > 0:
		ani.flip_h = false
		ani.play("walk")
	elif Hspeed < 0:
		ani.flip_h = true
		ani.play("walk")
	else :
		ani.play("idle")
	
	if is_sliding:
		ani.play("slide")

func _on_player_animation_animation_finished() -> void:
	if ani.animation == "hurt":
		is_hurt = false
		get_node("../").input_enabled = true
	pass # Replace with function body.
