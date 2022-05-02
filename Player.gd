extends KinematicBody2D

# These are the variables used to rotate the sword with player movement, and 
# allow the attack command to make the sword visible.
onready var sword = $Sword
onready var swordSprite = $Sword/Sprite

var speed = 90
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
			pass
	
	velocity= move_and_slide(velocity)

func get_input():
	velocity = Vector2.ZERO
	
	# Basic 4-way movement to replicate Zelda 1. I need to find a way to make it
	# that if the opposite directions are pressed it stops movement.
	# I think I better mimiced how Z1 handles directions. I need to work on
	# animations so I can better get a feeling of what I'm making.
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		sword.rotation_degrees = 180
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		sword.rotation_degrees = 0
	else:
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			sword.rotation_degrees = 90
		elif Input.is_action_pressed("ui_right"):
			velocity.x += 1
			sword.rotation_degrees = 270
	
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
