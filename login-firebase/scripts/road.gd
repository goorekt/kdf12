extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (AutoloadData.is_in_pause_menu):
		$Player.position=AutoloadData.player_position
		AutoloadData.is_in_pause_menu=false
	pass # Replace with function body.

func _process(delta):
	if (Input.is_action_pressed("esc")):
		AutoloadData.is_in_pause_menu=true
		AutoloadData.player_position=$Player.position
		get_tree().change_scene("res://scn/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_toSchool_body_entered(body):
	if body.is_in_group("player"):
		AutoloadData.taken=false
		AutoloadData.change_scene("res://scn/school.tscn")
