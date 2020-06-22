extends Area2D

onready var anim = get_node("AnimationPlayer")

export var score: = 50

func _on_body_entered(body):
	picked()

func picked() -> void:
	PlayData.set_score(score)
	anim.play("fade_out")
