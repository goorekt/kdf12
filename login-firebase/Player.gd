
##export var walk_speed = 4.0

##const TILE_SIZE = 16

#var initial_position = Vector2(0,0)
#var input_direction = Vector2(0,0)
#var is_moving = false
#var percent_moved_to_next_tile = 0.0

# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#initial_position = position
	
#func _physics_process(delta):
#	if is_moving == false:
#		process_player_input()
#	elif input_direction != Vector2.ZERO:
###		is_moving = false
	
#func process_player_input():
#	if input_direction.y == 0:
#		input_direction.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
#	if input_direction.x == 0:
#		input_direction.x = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))

#	if input_direction != Vector2.ZERO:
#		initial_position = position
#		is_moving = true
	

#func move(delta):
#	percent_moved_to_next_tile += walk_speed * delta
#	if percent_moved_to_next_tile >= 1.0:
#		position = initial_position + (TILE_SIZE * input_direction)
#		percent_moved_to_next_tile = 0.0
#		is_moving = false
#	else:
#		position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
extends KinematicBody2D
export var is_boy = true
var start=false
onready var boy=$Boy
onready var girl=$Girl
onready var atSchool = false
export (int) var speed = 200


var velocity = Vector2()
var direction="idle"

func get_input():
	
	if is_boy:
		velocity = Vector2()
		if Input.is_action_pressed('right'):
			velocity.x += 1
			boy.set_flip_h(false)
		if Input.is_action_pressed('left'):
			velocity.x -= 1
			boy.set_flip_h(true)
		if Input.is_action_pressed('down'):
			velocity.y += 1
	
		if Input.is_action_pressed('up'):
			velocity.y -= 1
		
		
		if Input.is_action_pressed("right"):
			direction="right"
		elif Input.is_action_pressed("left"):
			direction="left"
		elif Input.is_action_pressed("up"):
			direction="up"
		elif Input.is_action_pressed("down"):
			direction="down"
		
		
		
		if (velocity.x==0 and velocity.y==0):
			if (direction=="left"):
				boy.play("IdleRight")
				boy.set_flip_h(true)
			elif (direction == "right"):
				boy.play("IdleRight")
				boy.set_flip_h(false)
			elif (direction == "up"):
				boy.play("IdleUp")
			elif (direction == "down"):
				boy.play("IdleDown")
		else:
			if (direction=="left"):
				boy.play("Right")
				boy.set_flip_h(true)
			elif (direction == "right"):
				boy.play("Right")
				boy.set_flip_h(false)
			elif (direction == "up"):
				boy.play("Up")
			elif (direction == "down"):
				boy.play("Down")
	else:
		velocity = Vector2()
		if Input.is_action_pressed('right'):
			velocity.x += 1
			girl.set_flip_h(false)
			
		if Input.is_action_pressed('left'):
			velocity.x -= 1
			girl.set_flip_h(true)
		if Input.is_action_pressed('down'):

			velocity.y += 1

		if Input.is_action_pressed('up'):

			velocity.y -= 1

		
		if Input.is_action_pressed("right"):
			direction="right"
		elif Input.is_action_pressed("left"):
			direction="left"
		elif Input.is_action_pressed("up"):
			direction="up"
		elif Input.is_action_pressed("down"):
			direction="down"
			
		if (velocity.x==0 and velocity.y==0):
			if (direction=="left"):
				girl.play("IdleRight")
				girl.set_flip_h(true)
			elif (direction == "right"):
				girl.play("IdleRight")
				girl.set_flip_h(false)
			elif (direction == "up"):
				girl.play("IdleUp")
			elif (direction == "down"):
				girl.play("IdleDown")
		else:
			if (direction=="left"):
				girl.play("Right")
				girl.set_flip_h(true)
			elif (direction == "right"):
				girl.play("Right")
				girl.set_flip_h(false)
			elif (direction == "up"):
				girl.play("Up")
			elif (direction == "down"):
				girl.play("Down")
			
	
	velocity = velocity.normalized() * speed


func _ready():
	add_to_group("player")
	is_boy=AutoloadData.is_boy
	girl.set_speed_scale(1.5)
	boy.set_speed_scale(1.5)
	if is_boy:
		boy.show()
		girl.hide()
	else:
		girl.show()
		boy.hide()
func _physics_process(delta):
		
		
	get_input()
	if AutoloadData.taking_test:
		return
	velocity = move_and_slide(velocity)

