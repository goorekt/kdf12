extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var test_scene=preload("res://scn/Test.tscn")
onready var test_position=$testPos

func _ready():
	$karakterblad.hide()


func _process(delta):
	if (Input.is_action_pressed("esc")):
		get_tree().change_scene("res://scn/menu.tscn")


func _on_toHome_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scn/bedroom.tscn")


func _on_takeTest_body_entered(body):

	
	if body.is_in_group("player"):
		$testArrow.hide()
		AutoloadData.taking_test=true
		$Test.show()


func _on_Test_test_over():
	var score_display=""
	if (AutoloadData.current_score==0 or AutoloadData.current_score==2):
		score_display="0"
	$karakterblad/Label.text=score_display+str(AutoloadData.current_score)
