extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var grades : Label = $Container/VBoxContainer/Grades/Label
onready var tests : Label = $Container/VBoxContainer/Tests/Label
onready var time : Label = $Container/VBoxContainer/Time/Label
onready var notification : Label = $Container/Notification

var new_profile := false
var information_sent := false
var profile := {
	"grades": {},
	"tests": {},
	"time": {}
} setget set_profile


func _ready() -> void:
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)

#Tilføj HTTPRequest node til scenen og lav signal
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			notification.text = "Please, enter your information"
			new_profile = true
			return
		200:
			if information_sent:
				notification.text = "Information saved successfully"
				information_sent = false
			self.profile = result_body.fields

#Bruges til at hente data fra databasen og ændre notes i godot
func set_profile(value: Dictionary) -> void:
	profile = value
	grades.text = profile.grades.arrayValue
	tests.text = profile.tests.intengerValue
	time.text = profile.time.intengerValue
