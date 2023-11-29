extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer/name/Label2
onready var age : LineEdit = $Container/VBoxContainer/age/Label2

onready var gender_sprite=$sprite
onready var popup=$popup
var selected_gender
var new_profile := false
var information_sent := false
var profile := {
	"name": {},
	"age": {},
	"character": {}
} setget set_profile

func _ready() -> void:
	gender_sprite.play("boy")
	print("load_statistic")
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)

#Tilføj HTTPRequest node til scenen og lav signal
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	print("start httprequest")
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("404")
			popup("Please, enter your information")
			new_profile = true
			return
		200:
			print("200")
			if information_sent:
				popup("Information saved successfully")
				information_sent = false
			self.profile = result_body.fields

func popup(text):
	popup.dialog_text=text
	popup.show()
func _on_Button_pressed() -> void:
	print("button pressed")
	profile.name = { "stringValue": username.text } # Erstat med variabel der holder værdien
	profile.age = { "integerValue": age.text } # Erstat med variabel der holder værdien
	profile.character = { "stringValue": selected_gender } # Erstat med variabel der holder værdien
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
	selected_gender = profile.character.stringValue
	change_gender()
	change_gender()


func change_gender():
	if (selected_gender=="boy"):
		selected_gender="girl"
		gender_sprite.play("girl")
	else:
		selected_gender="boy"
		gender_sprite.play("boy")
		
func _on_Button2_pressed():
	get_tree().change_scene("")


func _on_next_pressed():
	change_gender()


func _on_previous_pressed():
	change_gender()
