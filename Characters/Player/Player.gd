extends "res://Characters/Character.gd"

signal update_camera

enum {
	MOVE,
	ATTACK
}

var state = MOVE

func _ready():
	animTree.active = true

func _physics_process(_delta):
	match state:
		MOVE:
			get_input()
		ATTACK:
			attack()

func get_input():
	var movementVector = Vector2.ZERO
#	 Basic 4-way movement to replicate Zelda 1. This also rotates the sword
#	 sprite and sets the player animation to match direction.
	if Input.is_action_pressed("ui_up"):
		movementVector.y -= 1
	elif Input.is_action_pressed("ui_down"):
		movementVector.y += 1
	else:
		if Input.is_action_pressed("ui_left"):
			movementVector.x -= 1
		elif Input.is_action_pressed("ui_right"):
			movementVector.x += 1
	
	if movementVector != Vector2.ZERO:
		animTree.set("parameters/Attack/blend_position", movementVector)
		animTree.set("parameters/Move/blend_position", movementVector)
		animTree.set_process_mode(1)
	else:
		pass
		animTree.set_process_mode(2)
	
	move_by_vector(movementVector)
	
	# I don't really like how it keeps having to go into PlayerStatistics to
	# check the value of swords. I feel like having an item singleton or even
	# placing the sword on the Player itself. The only issue with that will
	# be saving in the future... But It's a learning process.
	if Input.is_action_just_pressed("ui_select"):
		if PlayerStatistics.playerSword != PlayerStatistics.swords.NO_SWORD:
			state = ATTACK

# Attack function that ZEROs movement then sets animation tree to play, and
# run the Attack state.
func attack():
	animTree.set_process_mode(1)
	animState.travel("Attack")
	movementVector = Vector2.ZERO

# After attack is done, travels back to MOVE state.
func attack_end():
	animTree.set_process_mode(2)
	animState.travel("Move")
	state = MOVE


"""
Will need to make it so it checks if it is a new map cluster, or the same map.
If the same map just tell gamplay to tween the camera. But if new map cluster
do the other cool shit.
"""
func _on_MapDetectBox_area_entered(area):
	var mapName = area.get_parent().name
	var mapPosition = area.get_parent().position
	print("Location: ", mapName, " ", mapPosition)
	
	emit_signal("update_camera", mapPosition)
