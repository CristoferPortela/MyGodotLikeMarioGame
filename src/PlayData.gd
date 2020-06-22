extends Node

signal score_updated
signal player_died

var _score: = 0 setget set_score, get_score
var _deaths: = 0 setget set_deaths, get_deaths
var _lives: = 3 setget set_lives, get_lives

var  more_life = 3000

func reset() -> void:
	_score = 0
	_deaths = 0
	_lives = 3

func set_score(value: int) -> void:
	_score += value
	more_life()
	emit_signal("score_updated")

func get_score() -> int:
	return _score

func set_deaths(value: int) -> void:
	_deaths += value
	emit_signal("player_died")

func get_deaths() -> int:
	return _deaths

func set_lives(live = 1) -> void:
	_lives -= live
	
func get_lives() -> int:
	return _lives

func more_life() -> void:
	if _score >= more_life:
		set_lives(-1)
		more_life += 3000 
