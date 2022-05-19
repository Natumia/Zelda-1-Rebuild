extends Camera2D

func _ready():
	pass

func slide_camera(mapPosition):
	if self.position != mapPosition:
		var tween = $Tween
		tween.interpolate_property(self, "position", self.position, mapPosition, 1.7, Tween.TRANS_LINEAR)
		tween.start()
		get_tree().paused = true

func _on_Tween_tween_completed(_object, _key):
	get_tree().paused = false

