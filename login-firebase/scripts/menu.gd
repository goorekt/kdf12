extends Control

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	get_tree().change_scene("")


func _on_SettingsButton_pressed():
	get_tree().change_scene("res://scn/settings.tscn")


func _on_StatisticsButton_pressed():
	get_tree().change_scene("res://scn/statistics.tscn")
