extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_boy=true
var current_score=5
var taken=false
var current_time=0
var taking_test=false
var player_position=Vector2(0,0)
var current_scene
var is_in_pause_menu=false
var playername
var first_time_settings=true
var second_exam_set=false
func _ready():
	pass


func change_scene(scene):
	$door2.play(0.7)
	current_scene=scene
	
	get_tree().change_scene(scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	pass
