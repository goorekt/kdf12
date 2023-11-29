extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var test_scene=preload("res://scn/Test.tscn")
onready var test_position=$testPos

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_toHome_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scn/bedroom.tscn")


func _on_takeTest_body_entered(body):
	if body.is_in_group("player"):
		var test=test_scene.instance()
		test_position.add_child(test)
