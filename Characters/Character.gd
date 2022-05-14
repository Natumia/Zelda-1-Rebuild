extends KinematicBody2D
# This is the parent for all classes under Character.

onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree

export var movementSpeed = 80

var movementVector = Vector2.ZERO
var animState

func _ready():
	animState = animTree.get("parameters/playback")

func move_by_vector(inputVector):
	inputVector = inputVector * movementSpeed
	inputVector = move_and_slide(inputVector)
