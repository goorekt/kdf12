extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var grade : Label = $Container/VBoxContainer/Grades/Label2
onready var time : Label = $Container/VBoxContainer/Time/Label2

var new_profile := false
var information_sent := false
var profile := {
	"grade": {},
	"time": {}
} setget set_profile

func _ready() -> void:
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)

#Tilføj HTTPRequest node til scenen og lav signal
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			new_profile = true
			return
		200:
			if information_sent:
				information_sent = false
			self.profile = result_body.fields

#Bruges til at hente data fra databasen og ændre notes i godot
func set_profile(value: Dictionary) -> void:
	if ("grade" in profile and "time" in profile and 
		"integerValue" in profile.grade and "integerValue" in profile.time):
		grade.text = str(profile.grade.integerValue)
		time.text = str(profile.time.integerValue)
	else:
		grade.text = "?"
		time.text = "?"


func _on_Button_pressed():
	get_tree().change_scene("res://scn/menu.tscn")
