extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var grades : Label = $Container/VBoxContainer/Grades/Label2
onready var tests : Label = $Container/VBoxContainer/Tests/Label2
onready var time : Label = $Container/VBoxContainer/Time/Label2
onready var notification : Label = $Container/Notification

var new_profile := false
var information_sent := false
var profile := {
	"grades": {},
	"tests": {},
	"time": {}
} setget set_profile

func _ready() -> void:
	print("load_statistic")
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)

#Tilføj HTTPRequest node til scenen og lav signal
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	print("start httprequest")
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("404")
			notification.text = "Please, enter your information"
			new_profile = true
			return
		200:
			print("200")
			if information_sent:
				notification.text = "Information saved successfully"
				information_sent = false
			self.profile = result_body.fields

#Bruges til at hente data fra databasen og ændre notes i godot
func set_profile(value: Dictionary) -> void:
	print("set profile")
	profile = value
	var grades_array = []

	# Assuming profile.grades is a mapValue
	var grades_map = profile.grades.mapValue.fields

	for key in grades_map.keys():
		var value2 = grades_map[key].integerValue
		grades_array.append(value2)

	# Now grades_array contains the integer values from the grades map
	grades.text = str(grades_array)
	tests.text = str(profile.tests.integerValue)
	time.text = str(profile.time.integerValue)


func _on_Button_pressed():
	get_tree().change_scene("")
