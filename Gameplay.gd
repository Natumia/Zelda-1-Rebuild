extends Node2D

func _ready():
	pass

func update_camera(value):
	if $Camera2D.position != value:
		var tween = $Camera2D/Tween
		tween.interpolate_property($Camera2D, "position", $Camera2D.position, value, 1.7, Tween.TRANS_LINEAR)
		tween.start()
		get_tree().paused = true

func _on_Tween_tween_completed(_object, _key):
	get_tree().paused = false
