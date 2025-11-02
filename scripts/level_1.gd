extends Node2D

var scroll_speed = 30
var backgrounds = []


func _ready() -> void:
	get_tree().paused = false
	$bgm.play()
	$UI/transition_animation.show()
	$UI.load_in_animation(false)
	backgrounds = [$BG/bg_2, $BG/bg_2_2]

func _process(delta: float) -> void:
	for bg in backgrounds:
		bg.position.y += scroll_speed * delta
		
		if bg.position.y >= 648:
			var another_bg
			if bg == backgrounds[0]:
				another_bg = backgrounds[1]
			else: 
				another_bg = backgrounds[0]
			bg.position.y = -750

func lose():
	Controller.lost_fruit()
	$dead.play()
	$Timer.start()
	get_tree().paused = true
	$UI/Control/dead_panel.show()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	$dead2.play()
	pass # Replace with function body.
