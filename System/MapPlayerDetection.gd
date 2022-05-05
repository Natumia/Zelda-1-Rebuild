extends Node2D

func _ready():
	var playerDetection = get_node("MapPlayerDetection")
	playerDetection.connect("body_entered", self, "player_entered")

func player_entered(_body):
	print(name)
	var mapPosition = position
	var mapCluster = get_parent()
	mapCluster.get_parent().update_camera(mapPosition)
