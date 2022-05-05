extends Node2D

onready var playerCamera = $Camera2D

func _ready():
	pass

func update_camera(value):
	get_tree().paused = true
	playerCamera.set_position(value)
	if playerCamera.position == value:
		get_tree().paused = false
