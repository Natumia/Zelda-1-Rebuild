extends Node2D

onready var playerCamera = $Camera2D
onready var cameraTimer = $Camera2D/Timer


func _ready():
	pass

func update_camera(value):
	get_tree().paused = true
	playerCamera.set_position(value)
	cameraTimer.start()

func _on_Timer_timeout():
	get_tree().paused = false

