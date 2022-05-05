extends Node2D

var currentMap = preload("res://Maps/H6OverworldMap.tscn").instance()
var playerCharacter = preload("res://Player/Player.tscn").instance()

onready var gameArea = $GameArea
onready var currentMapLocation = $CurrentMapLocation

func _ready():
	get_node("GameArea").add_child(currentMap)
	currentMap.position = currentMapLocation.position
	get_node("GameArea").add_child(playerCharacter)
	playerCharacter.position = Vector2(128, 152)
