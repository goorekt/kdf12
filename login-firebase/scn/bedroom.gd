extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pause_node=$pausescreen

onready var pause_mode_bedroom=false
var pause_screen
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if (AutoloadData.is_in_pause_menu):
		$YSort/Player.position=AutoloadData.player_position
		AutoloadData.is_in_pause_menu=false
	AutoloadData.current_scene="res://scn/bedroom.tscn"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("esc")):
		AutoloadData.is_in_pause_menu=true
		AutoloadData.player_position=$YSort/Player.position
		get_tree().change_scene("res://scn/menu.tscn")


func _on_toSchool_body_entered(body):
	if body.is_in_group("player"):
		AutoloadData.change_scene("res://scn/road.tscn")


