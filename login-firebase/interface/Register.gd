extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var email : LineEdit = $Container/VBoxContainer/email/LineEdit
onready var password : LineEdit = $Container/VBoxContainer/password/LineEdit
onready var confirm : LineEdit = $Container/VBoxContainer/confirm_password/LineEdit
onready var notification : Label = $Container/Notification


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
	else:
		notification.text = "Registration sucessful!"
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://interface/Login.tscn")


func _on_RegisterButton_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	if password.text != confirm.text or email.text.empty() or password.text.empty():
		notification.text = "Invalid password or email"
		return
	Firebase.register(email.text, password.text, http)



func _on_Back_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://Main.tscn")
