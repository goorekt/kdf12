extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer/name/Label2
onready var age : LineEdit = $Container/VBoxContainer/age/Label2

onready var gender_sprite=$sprite
onready var popup=$popup
var selected_gender="boy"
var new_profile := false
var information_sent := false
var profile := {
	"name": {},
	"age": {},
	"character": {}
} setget set_profile

func _ready() -> void:
	if(AutoloadData.first_time_settings):
		$Container/VBoxContainer2/Button2.hide()
	gender_sprite.play("boy")
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
			if (self.profile.character.stringValue=="boy"):
				AutoloadData.is_boy=true
			else:
				AutoloadData.is_boy=false


func _on_Button_pressed() -> void:
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	AutoloadData.playername=username.text
	profile.name = { "stringValue": username.text } # Erstat med variabel der holder værdien
	profile.age = { "integerValue": age.text } # Erstat med variabel der holder værdien
	profile.character = { "stringValue": selected_gender } # Erstat med variabel der holder værdien
	match new_profile:
		true:
			Firebase.save_document("users?documentId=%s" % Firebase.user_info.id, profile, http)
		false:
			Firebase.update_document("users/%s" % Firebase.user_info.id, profile, http)
	information_sent = true
	yield(get_tree().create_timer(2), "timeout")
	if (AutoloadData.first_time_settings):
		AutoloadData.first_time_settings=false
		get_tree().change_scene("res://scn/bedroom.tscn")
	else:
		get_tree().change_scene("res://scn/menu.tscn")
	



#Bruges til at hente data fra databasen og ændre notes i godot
func set_profile(value: Dictionary) -> void:
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
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scn/menu.tscn")


func _on_next_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	change_gender()


func _on_previous_pressed():
	$click.play(0.86)
	yield(get_tree().create_timer(0.5), "timeout")
	change_gender()
