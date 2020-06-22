tool
extends Area2D

onready var anim: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

func _on_Portal_body_entered(body):
	teleport()

func _get_configuration_warning():
	return "The next scene propert can't be empty" if not next_scene else ""

func teleport() -> void:
	anim.play("fade_in")
	yield(anim, "animation_finished")
	get_tree().change_scene_to(next_scene)





