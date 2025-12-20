extends Node

signal coin_destruct
var score = 0

func coin_pickup(value):
	score = score + value
	coin_destruct.emit()
