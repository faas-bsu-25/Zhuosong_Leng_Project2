extends Node2D

@export var scene_to_load: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$start_bgm.play()
	$UI/Control/start_panel.show()
	$UI/Control/fruit_num.hide()
	$UI/Control/health.hide()
	pass # Replace with function body.


func _on_start_button_pressed() -> void:
	$UI/transition_animation.show()
	$transition_latency.start()
	$UI.load_in_animation(true)
	pass # Replace with function body.


func _on_transition_latency_timeout() -> void:
	get_tree().change_scene_to_file(scene_to_load)
	pass # Replace with function body.
