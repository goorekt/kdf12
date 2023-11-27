extends Control


func _on_RegisterButton_pressed():
	get_tree().change_scene("res://interface/Register.tscn")


func _on_LoginButton_pressed():
	get_tree().change_scene("res://interface/Login.tscn")
