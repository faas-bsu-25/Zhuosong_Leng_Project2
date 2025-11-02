extends CharacterBody2D


var SPEED = 100.0
const JUMP_VELOCITY = -200.0
var state = "idle"
var stable_state = ["idle", "play", "scratch"]
var already_stable = false
var is_movable = false
var on_wall = false

@export var catalog: Label
@export var end_catalog: Label
@onready var ani = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle state
	var player_dir = get_node("../../player").position - self.position
	if player_dir.length() > 30 and is_movable:
		if player_dir.length() < 30: 
			state = "chase"
			SPEED = 100
		elif player_dir.length() < 150:
			state = "chase"
			SPEED = 220
	else:
		state  = "idle"
	
	# Handle animation direction
	if player_dir.normalized().x > 0:
		ani.flip_h = true
	elif player_dir.normalized().x < 0:
		ani.flip_h = false
	
	# Handle moving
	if state == "chase":
		if not on_wall:
			self.velocity.x = player_dir.normalized().x * SPEED
			$motion_duration.stop()
			ani.play("walk")
			already_stable = false
		else:
			self.velocity.x = player_dir.normalized().x * SPEED
			self.velocity.y = JUMP_VELOCITY
			$motion_duration.stop()
			ani.play("walk")
			already_stable = false
	elif not already_stable and state == "idle":
		self.velocity.x = 0
		$motion_duration.start()
		ani.play("idle")
		already_stable = true
	move_and_slide()
	
	on_wall = false
	for i in range(get_slide_collision_count()):
		var collision  = get_slide_collision(i)
		var normal = collision.get_normal()
		if normal.x:
			on_wall = true


func _on_motion_duration_timeout() -> void:
	ani.play(stable_state.pick_random())
	pass # Replace with function body.


func _on_catalog_trigger_body_entered(body: CharacterBody2D) -> void:
	if body.name == "player":
		$greeting.play()
		$catalog_trigger/duration.start()
		catalog.text = "I am lost with my friends.
		Could you take me to where they are,
		I think it won't be too far."
	pass # Replace with function body.


func _on_duration_timeout() -> void:
	is_movable = true
	$catalog_trigger/CollisionShape2D.disabled = true
	catalog.text = ""
	pass # Replace with function body.


func _on_complete_area_body_entered(body: CharacterBody2D) -> void:
	if body.name == "player":
		is_movable = false
		get_node("../complete_area/duration_2").start()
		get_node("../../BG/keys2").show()
		end_catalog.text = "Thank you for your help.
		I got a key before,
		no worries, I will give it to you!"
	pass # Replace with function body.


func _on_duration_2_timeout() -> void:
	get_node("../complete_area/CollisionShape2D").disabled = true
	get_node("../../BG/keys2/CollisionShape2D").disabled = false
	end_catalog.text = ""
	pass # Replace with function body.
