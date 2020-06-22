extends Actor

export var stomp_impulse = 1250.0

#func _on_StompDetector_area_entered(area):
#	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# warning-ignore:unused_argument
func _on_EnemyDetector_body_entered(body):
	die()
	
# warning-ignore:unused_argument
func _on_StompDetector_body_entered(body):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# warning-ignore:unused_argument
func _physics_process(delta):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	var walk: = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") 
	var jump: = -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0	
	
	if walk > 0:
		$player.play("run_right")
	elif walk < 0:
		$player.play("run_left")
	else:
		$player.play("stop")
	
	return Vector2(walk, jump)

func calculate_move_velocity(
 linear_velocity: Vector2, 
 direction: Vector2, 
 speed: Vector2, 
 is_jump_interrupted: bool
) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out
	
func calculate_stomp_velocity(
linear_velocity: Vector2, 
impulse: float
) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func die() -> void:
	PlayData.set_deaths(1)
	
	if PlayData.get_deaths() < PlayData.get_lives():
		get_tree().paused = false
		get_tree().reload_current_scene()
	else:
		PlayData.reset()
		queue_free()
