extends Control

onready var label: = $Label

func _ready() -> void:
	label.text = label.text % [PlayData.get_score(), PlayData.get_lives()]
