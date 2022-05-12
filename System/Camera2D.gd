extends Camera2D

signal new_map

func _ready():
	var player = get_node("../Player")
	if player != null:
		player.connect("update_camera", self, "_on_Player_update_camera") 

func _on_Player_update_camera(mapPosition, mapName, mapDestination):
	if mapName != "MapEntrance":
		if self.position != mapPosition:
			print("Going to " + mapName)
			var tween = $Tween
			tween.interpolate_property(self, "position", self.position, mapPosition, 1.7, Tween.TRANS_LINEAR)
			tween.start()
			get_tree().paused = true
	else:
		print("Hellos")

func _on_Tween_tween_completed(_object, _key):
	get_tree().paused = false
	
