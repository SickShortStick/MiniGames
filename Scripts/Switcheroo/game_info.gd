extends Node


var score = 0
var high_score = 0
var lost = false


func scored():
	score += 1


func game_over():
	lost = true
	get_tree().call_group("Spikes", "stop")
