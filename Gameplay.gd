extends Node2D

func _ready():
	var player = get_node_or_null("Player")
	if player != null:
		player.connect("update_camera", self, "_on_Player_update_camera") 

func _on_Player_update_camera(mapPosition, mapName):
	if $Camera2D.position != mapPosition:
		print(mapName)
		var tween = $Camera2D/Tween
		tween.interpolate_property($Camera2D, "position", $Camera2D.position, mapPosition, 1.7, Tween.TRANS_LINEAR)
		tween.start()
		get_tree().paused = true

func _on_Tween_tween_completed(_object, _key):
	get_tree().paused = false
	
