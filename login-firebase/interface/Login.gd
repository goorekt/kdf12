extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer/Username/LineEdit
onready var password : LineEdit = $Container/VBoxContainer/Password/LineEdit
onready var notification : Label = $Container/Notification


func _on_LoginButton_pressed():
	if username.text.empty() or password.text.empty():
		notification.text = "Please, enter your username and password"
		return
	Firebase.login(username.text, password.text, http)
	$Container/VBoxContainer/LoginButton.disabled = true


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
		$Container/VBoxContainer/LoginButton.disabled = false
	else:
		notification.text = "Sign in sucessful!"
		


func _on_Back_pressed():
	get_tree().change_scene("res://Main.tscn")
