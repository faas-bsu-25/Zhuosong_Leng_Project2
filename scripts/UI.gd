extends CanvasLayer


var is_end
@export var heart_1: TextureRect
@export var heart_2: TextureRect
@export var heart_3: TextureRect
@export var half_heart: Texture2D


func _ready() -> void:
	Controller.fruit_collected.connect(fruit_collected)
	show_num()


func fruit_collected():
	show_num()


func show_num():
	$Control/fruit_num/apple_Label.text = str(Controller.apple_collected)
	$Control/fruit_num/banana_Label.text = str(Controller.banana_collected)
	$Control/fruit_num/cherry_Label.text = str(Controller.cherry_collected)
	$Control/fruit_num/melon_Label.text = str(Controller.melon_collected)
	$Control/fruit_num/orange_Label.text = str(Controller.orange_collected)


func scaling_animation(group: String):
	for sprite in get_tree().get_nodes_in_group(group):
		var tween = create_tween()
		if is_end:
			sprite.scale = Vector2(0, 0)
			tween.tween_property(sprite, "scale", Vector2(6, 6), 0.3)
		else:
			sprite.scale = Vector2(6, 6)
			tween.tween_property(sprite, "scale", Vector2(0, 0), 0.3)


func update_hearts(current_hp: int):
	if current_hp == 5:
		heart_3.texture = half_heart
	elif current_hp == 4:
		heart_3.queue_free()
	elif current_hp == 3:
		heart_2.texture = half_heart
	elif current_hp == 2:
		heart_2.queue_free()
	elif current_hp == 1:
		heart_1.texture = half_heart
	elif current_hp == 0:
		heart_1.queue_free()


func load_in_animation(is_end: bool):
	self.is_end = is_end
	$column2_latency.start()
	scaling_animation("scalable_sprites_1")

func _on_column_2_latency_timeout() -> void:
	$column3_latency.start()
	scaling_animation("scalable_sprites_2")

func _on_column_3_latency_timeout() -> void:
	$column4_latency.start()
	scaling_animation("scalable_sprites_3")

func _on_column_4_latency_timeout() -> void:
	$column5_latency.start()
	scaling_animation("scalable_sprites_4")

func _on_column_5_latency_timeout() -> void:
	$column6_latency.start()
	scaling_animation("scalable_sprites_5")

func _on_column_6_latency_timeout() -> void:
	scaling_animation("scalable_sprites_6")
