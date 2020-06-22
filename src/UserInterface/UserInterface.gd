extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: = $PauseOverlay
onready var score: = $Label
onready var lives: = $lives
onready var pause_title: = $PauseOverlay/Title

var paused: = false setget set_paused

func _ready() -> void:
	PlayData.connect("score_updated", self, "update_interface")
	PlayData.connect("player_died", self, "_on_PlayData_player_died")
	update_interface()

func _on_PlayData_player_died() -> void:
	self.paused = true
	pause_title.text = "Você morreu"

func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause") and PlayData.get_lives() != 0:
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused =  value
	pause_overlay.visible = value

func update_interface() -> void:
	score.text = "Score: %s" % PlayData.get_score()
	lives.text = "Vidas: %s" % (PlayData.get_lives() - PlayData.get_deaths())
