extends Node2D

onready var player = get_node("Player")
onready var camera = get_node("Camera2D")

func _ready():
	if player != null:
		player.connect("update_camera", self, "moved_map") 

"""
So will need to get the new map cluster.
Queue free the old map.
Instance new map.
Set camera location to entrance.
Set player location to entrance of the new map.
"""
func new_map():
	pass

func moved_map(mapPosition):
	camera.slide_camera(mapPosition)
