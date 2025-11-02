extends Node2D

var scroll_speed = 30
var backgrounds1 = []
var backgrounds2 = []


func _ready() -> void:
	get_tree().paused = false
	$bgm.play()
	$player/Camera2D.limit_right = 2320
	$UI/transition_animation.show()
	$BG/keys2.hide()
	$BG/keys2/CollisionShape2D.disabled = true
	
	$UI.load_in_animation(false)
	backgrounds1 = [$BG/bg_3, $BG/bg_3_2]
	backgrounds2 = [$BG/bg_3_3, $BG/bg_3_4]


func _process(delta: float) -> void:
	for bg in backgrounds1:
		bg.position.y += scroll_speed * delta
		
		if bg.position.y >= 648:
			var another_bg
			if bg == backgrounds1[0]:
				another_bg = backgrounds1[1]
			else:
				another_bg = backgrounds1[0]
			bg.position.y = -750
	
	for bg in backgrounds2:
		bg.position.y += scroll_speed * delta
		
		if bg.position.y >= 648:
			var another_bg
			if bg == backgrounds2[0]:
				another_bg = backgrounds2[1]
			else:
				another_bg = backgrounds2[0]
			bg.position.y = -750

func lose():
	Controller.lost_fruit()
	$dead.play()
	$Timer.start()
	get_tree().paused = true
	$UI/Control/dead_panel.show()

func win():
	get_tree().paused = true
	$UI/Control/end_panel.show()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	$dead2.play()
	pass # Replace with function body.

func _on_dead_area_body_entered(body: Node2D) -> void:
	lose()
	pass # Replace with function body.
