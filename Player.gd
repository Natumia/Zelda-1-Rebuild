extends KinematicBody2D

# Animation player for the player sprite. I really need to invest time to make
# this into a tree and blend between the animations. Maybe not for this project.
onready var animationPlayer = $AnimationPlayer

# These are the variables used to rotate the sword with player movement, and 
# allow the attack command to make the sword visible.
onready var sword = $Sword
onready var swordSprite = $Sword/Sprite

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
			animationPlayer.stop(false)
			get_input()
		MOVE:
			animationPlayer.play()
			get_input()
		ATTACK:
			pass
	
	velocity= move_and_slide(velocity)

func get_input():
	velocity = Vector2.ZERO
	
	# Basic 4-way movement to replicate Zelda 1. This also rotates the sword
	# sprite and sets the player animation to match direction.
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		sword.rotation_degrees = 180
		animationPlayer.current_animation = "MoveUp"
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		sword.rotation_degrees = 0
		animationPlayer.current_animation = "MoveDown"
	else:
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			sword.rotation_degrees = 90
			animationPlayer.current_animation = "MoveLeft"
		elif Input.is_action_pressed("ui_right"):
			velocity.x += 1
			sword.rotation_degrees = 270
			animationPlayer.current_animation = "MoveRight"
	
	# The start of swinging the sword. It will stop the player from moving, 
	# by chaning the start to swing. Then after animation ends go back to
	# a movement state.
	if Input.is_action_just_pressed("ui_select"):
		
		swordSprite.visible = true
		
		# Creates a wait timer. This is TEMP.
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		
		velocity = Vector2.ZERO
		state = ATTACK
		print("Attack!")
		
		# Waits for timer to stop. This is TEMP.
		yield(t, "timeout")
		t.queue_free()
		
		swordSprite.visible = false
		
		state = IDLE
	
	if velocity != Vector2.ZERO:
		state = MOVE
	else:
		state = IDLE
	
	velocity = velocity.normalized() * speed
