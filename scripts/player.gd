extends CharacterBody2D

var HP = 6
var second_jump_enabled = true
var input_enabled = true
var on_land = true
var on_wall = false
var is_sliding = false
var normal
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var animator = $animator

func _physics_process(delta: float) -> void:	
	# Handle character's state
	on_land = is_on_floor()
	is_sliding = (not on_land and on_wall and velocity.y > 0)
	
	# Add the gravity.
	if not on_land and not is_sliding:
		velocity += get_gravity() * delta
	elif is_sliding:
		velocity.y = 50
	else:
		second_jump_enabled = true
	
	# operating while player being hurt is not allowed
	if not input_enabled:
		return
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (on_land or second_jump_enabled):
		$jump.play()
		velocity.y = JUMP_VELOCITY
		second_jump_enabled = false
	elif Input.is_action_just_pressed("jump") and is_sliding:
		$jump.play()
		velocity.y = JUMP_VELOCITY
		velocity.x = -normal.x * SPEED * 1.2
	
	# Handle moving.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# Check if collide with wall.
	on_wall = false
	for i in range(get_slide_collision_count()):
		var collision  = get_slide_collision(i)
		normal = collision.get_normal()
		if normal.x:
			on_wall = true
	
	
	animator.Hspeed = self.velocity.x
	animator.Vspeed = self.velocity.y
	animator.on_floor = on_land
	animator.is_sliding = is_sliding


func get_hurt():
	$hurt.play()
	HP -= 1
	get_node("../UI").update_hearts(HP)
	input_enabled = false
	animator.is_hurt = true
	if HP == 0:
		dead()


func dead():
	$CollisionShape2D.disabled = true
	$dead_latency.start()


func _on_dead_latency_timeout() -> void:
	get_node("../").lose()
	pass # Replace with function body.
