extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label=$Sprite/Label
onready var name_label=$Sprite/name

func _ready():
	label.text=AutoloadData.current_score
	name_label.text=AutoloadData.playername

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
