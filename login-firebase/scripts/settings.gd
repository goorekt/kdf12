extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer/Name/Label2
onready var age : LineEdit = $Container/VBoxContainer/Age/Label2
onready var character : LineEdit = $Container/VBoxContainer/Character/Label2
onready var notification : Label = $Container/Notification

var new_profile := false
var information_sent := false
var profile := {
	"name": {},
	"age": {},
	"character": {}
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


func _on_Button_pressed() -> void:
	print("button pressed")
	profile.name = { "stringValue": username.text } # Erstat med variabel der holder værdien
	profile.age = { "integerValue": age.text } # Erstat med variabel der holder værdien
	profile.character = { "integerValue": character.text } # Erstat med variabel der holder værdien
	match new_profile:
		true:
			Firebase.save_document("users?documentId=%s" % Firebase.user_info.id, profile, http)
			print("document saved")
		false:
			Firebase.update_document("users/%s" % Firebase.user_info.id, profile, http)
			print("document updated")
	information_sent = true
	print("information sent")



#Bruges til at hente data fra databasen og ændre notes i godot
func set_profile(value: Dictionary) -> void:
	print("set profile")
	profile = value
	# Now grades_array contains the integer values from the grades map
	username.text = profile.name.stringValue
	age.text = str(profile.age.integerValue)
	character.text = str(profile.character.integerValue)


func _on_Button2_pressed():
	get_tree().change_scene("")
