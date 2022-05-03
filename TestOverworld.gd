extends Node2D

var playerCharacter = preload("res://Player/Player.tscn").instance()

func _ready():
	add_child_below_node($OverworldTilemap, playerCharacter)
	playerCharacter.position = Vector2(128, 152)
