extends KinematicBody2D

# Animation player for the player sprite. I really need to invest time to make
# this into a tree and blend between the animations. Maybe not for this project.
onready var animationPlayer = $AnimationPlayer

var speed = 80
var velocity = Vector2.ZERO

enum {
	IDLE,
	MOVE,
	ATTACK
}

var state = IDLE

func _ready():
	pass

func _physics_process(_delta):
	
	match state:
		IDLE:
			get_input()
		MOVE:
			get_input()
		ATTACK:
			attack()
	
	velocity= move_and_slide(velocity)

func get_input():
	velocity = Vector2.ZERO
	
#	 Basic 4-way movement to replicate Zelda 1. This also rotates the sword
#	 sprite and sets the player animation to match direction.
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		animationPlayer.current_animation = "MoveUp"
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		animationPlayer.current_animation = "MoveDown"
	else:
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			animationPlayer.current_animation = "MoveLeft"
		elif Input.is_action_pressed("ui_right"):
			velocity.x += 1
			animationPlayer.current_animation = "MoveRight"
	
	if velocity != Vector2.ZERO:
		state = MOVE
		animationPlayer.play()
	else:
		state = IDLE
		animationPlayer.stop(false)
	
	if Input.is_action_just_pressed("ui_select"):
		velocity = Vector2.ZERO
		state = ATTACK
	
	velocity = velocity.normalized() * speed

# Attack function that's called in the attack state. It checks last used
# animation and plays the proper attack animation. 
func attack():
	if animationPlayer.assigned_animation == "MoveDown":
		animationPlayer.play("AttackDown")
	elif animationPlayer.assigned_animation == "MoveUp":
		animationPlayer.play("AttackUp")
	elif animationPlayer.assigned_animation == "MoveLeft":
		animationPlayer.play("AttackLeft")
	elif animationPlayer.assigned_animation == "MoveRight":
		animationPlayer.play("AttackRight")
