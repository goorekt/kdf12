extends Control


func _on_RegisterButton_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://interface/Register.tscn")


func _on_LoginButton_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://interface/Login.tscn")


func _on_quit_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()
