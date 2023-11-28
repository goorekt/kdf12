extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var notification : Label = $Container/Notification


var new_profile := false
var information_sent := false
var profile := {
	"grades": {},
	"tests": {},
	"time": {}
}


func _ready() -> void:
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)


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


func _on_ConfirmButton_pressed() -> void:
	profile.grades = {"arrayValue": {"values": null}} # Erstat med variabel der holder værdien
	profile.tests = { "integerValue": null } # Erstat med variabel der holder værdien
	profile.time = { "integerValue": null } # Erstat med variabel der holder værdien
	match new_profile:
		true:
			Firebase.save_document("users?documentId=%s" % Firebase.user_info.id, profile, http)
		false:
			Firebase.update_document("users/%s" % Firebase.user_info.id, profile, http)
	information_sent = true
