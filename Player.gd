extends KinematicBody2D

var speed = 90
var velocity = Vector2.ZERO

enum state {
	IDLE
	ATTACK
}

var currentState = state.IDLE

func _ready():
	pass 

func _physics_process(_delta):
	
	match currentState:
		state.IDLE:
			get_input()
		state.ATTACK:
			pass
	
	velocity= move_and_slide(velocity)

func get_input():
	velocity = Vector2.ZERO
	
	# Basic 4-way movement to replicate Zelda 1. I need to find a way to make it
	# that if the opposite directions are pressed it stops movement.
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 1
	else:
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		elif Input.is_action_pressed("ui_down"):
			velocity.y += 1
	
	# The start of swinging the sword. It will stop the player from moving, 
	# by chaning the start to swing. Then after animation ends go back to
	# a movement state.
	if Input.is_action_just_pressed("ui_select"):
		
		# Creates a wait timer. This is TEMP.
		var t = Timer.new()
		t.set_wait_time(0.3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		
		velocity = Vector2.ZERO
		currentState = state.ATTACK
		print("swing!")
		
		# Waits for timer to stop. This is TEMP.
		yield(t, "timeout")
		t.queue_free()
		
		currentState = state.IDLE
	
	velocity = velocity.normalized() * speed
