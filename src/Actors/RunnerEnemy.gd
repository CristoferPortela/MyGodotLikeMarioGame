extends "res://src/Actors/Actor.gd"

export var score: = 300

func _ready():
#	set_physics_process(false)
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body):
	if body.global_position.y > $StompDetector.global_position.y:
		return
	die()


func _on_SameKindDetector_body_entered(body):
	_velocity.x *= -1.0
	_velocity.y += -speed.y
	if body.global_position.y > $SameKindDetector.global_position.y && _velocity.y < 2000.0:
		_velocity.y *= -1.2

func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0 
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	queue_free()
	PlayData.set_score(score)
