extends Node


@onready var score_label: Label = $CanvasLayer/Control/ScoreLabel


func change_score_label():
	score_label.set_text(str(GameInfo.score))
