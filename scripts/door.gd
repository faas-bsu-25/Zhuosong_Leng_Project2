extends Area2D

var keys_needed
@export var scene_to_load: String
@export var alert: Label

func _ready() -> void:
	if get_node("../../").name == "Level0":
		keys_needed = 1
	elif get_node("../../").name == "Level1" or get_node("../../").name == "Level2":
		keys_needed = 2
	alert.text = ""


func _on_body_entered(body: CharacterBody2D) -> void:
	if Controller.key >= keys_needed:
		$win.play()
		if get_node("../../").name == "Level2":
			get_node("../../").win()
		else:
			Controller.use_key(keys_needed)
			get_node("../../UI").load_in_animation(true)
			$transition_latency.start()
	else:
		$lock.play()
		$text_duration.start()
		alert.text = "Don't forget your keys!   " + str(Controller.key) + "/" + str(keys_needed)
		pass # Replace with function body.


func _on_text_duration_timeout() -> void:
	alert.text = ""
	pass # Replace with function body.


func _on_transition_latency_timeout() -> void:
	get_tree().change_scene_to_file(scene_to_load)
	pass # Replace with function body.
