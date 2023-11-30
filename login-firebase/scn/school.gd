extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var test_scene=preload("res://scn/Test.tscn")
onready var test_position=$testPos

func _ready():
	
	$karakterblad.hide()
	if (AutoloadData.taken):
		$testArrow.hide()
	else:
		$homesign.hide()
	if (AutoloadData.is_in_pause_menu):
		$Player.position=AutoloadData.player_position
		AutoloadData.is_in_pause_menu=false

		
func _process(delta):
	if (Input.is_action_pressed("esc") and !AutoloadData.taking_test):
		AutoloadData.is_in_pause_menu=true
		AutoloadData.player_position=$Player.position
		get_tree().change_scene("res://scn/menu.tscn")


func _on_toHome_body_entered(body):
	if body.is_in_group("player"):

		AutoloadData.change_scene("res://scn/bedroom.tscn")
		


func _on_takeTest_body_entered(body):
	if body.is_in_group("player") and !AutoloadData.taken:
		$testArrow.hide()
		AutoloadData.taking_test=true
		$Test.show()


func _on_Test_test_over():
	
	AutoloadData.second_exam_set=!AutoloadData.second_exam_set
	var score_display=""
	$homesign.show()
	if (AutoloadData.current_score==0 or AutoloadData.current_score==2):
		score_display="0"
	if (AutoloadData.current_score>4):
		$goodscore.play()
	else:
		$badscore.play()
	
	$karakterblad/Label.text=score_display+str(AutoloadData.current_score)
	$karakterblad/Label2.text=AutoloadData.playername
	$karakterblad/Label3.text=str(AutoloadData.current_time)+" seconds"
	$karakterblad.show()
	yield(get_tree().create_timer(2), "timeout")
	$karakterblad.hide()



func _on_badscore_finished():
	$badscore.queue_free()


func _on_goodscore_finished():
	$goodscore.queue_free()

