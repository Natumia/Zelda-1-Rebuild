extends KinematicBody2D

var speed = 90
var velocity = Vector2.ZERO

func _ready():
	pass 

func _physics_process(_delta):
	get_input()
	velocity= move_and_slide(velocity)

# Basic 4-way movement to replicate Zelda 1. I need to find a way to make it
# that if the opposite directions are pressed it stops movement.
func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 1
	else:
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		elif Input.is_action_pressed("ui_down"):
			velocity.y += 1
	velocity = velocity.normalized() * speed
