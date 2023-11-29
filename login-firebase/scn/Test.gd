extends Node2D


onready var fontt=load("res://assets/misc/fonts/PTMono-Regular.ttf")
var questions = [
	{
		"text": "Hvad kaldes den grundlæggende enhed for arvemateriale i en celle?",
		"option_zero": "Kromosom",
		"option_one": "Ribosom",
		"option_two": "Lysosom",
		"option_three": "Mitokondrie",
		"correct": 0
	},
	{
		"text": "Hvad er funktionen af ​​ribosomer i en celle?",
		"option_zero": "At producere energi",
		"option_one": "At syntetisere proteiner",
		"option_two": "At nedbryde affaldsstoffer",
		"option_three": "At opbevare genetisk information",
		"correct": 1
	},
	{
		"text": "Hvad er den primære funktion af cellemembranen?",
		"option_zero": "At opretholde cellemembranpotentialet",
		"option_one": "At beskytte cellens indre strukturer",
		"option_two": "At give cellen form og struktur",
		"option_three": "At regulere transporten af stoffer ind og ud af cellen",
		"correct": 3
	},
	{
		"text": "Hvilket organel er ansvarligt for at nedbryde og genanvende affaldsstoffer i cellen?",
		"option_zero": "Ribosom",
		"option_one": "Lysosom",
		"option_two": "Golgi-apparatet",
		"option_three": "Endoplasmatisk reticulum",
		"correct": 1
	},
	{
		"text": "Hvilket organ fungerer som kroppens primære filter og renser blodet?",
		"option_zero": "Hjertet",
		"option_one": "Leveren",
		"option_two": "Nyrerne",
		"option_three": "Maven",
		"correct": 2
	},
	{
		"text": "Hvad er funktionen af DNA i cellen?",
		"option_zero": "At danne energi",
		"option_one": "At transportere næringsstoffer",
		"option_two": "At syntetisere proteiner",
		"option_three": "At lagre genetisk information",
		"correct": 3
	},
	{
		"text": "Hvad er formålet med mitose i en cellecyklus?",
		"option_zero": "At producere kønsceller",
		"option_one": "At danne genetisk variation",
		"option_two": "At producere identiske datterceller",
		"option_three": "At reparere beskadigede celler",
		"correct": 2
	},
	{
		"text": "Hvilken proces omdanner solenergi til kemisk energi i planter?",
		"option_zero": "Respiration",
		"option_one": "Fotosyntese",
		"option_two": "Gæring",
		"option_three": "Fototropisme",
		"correct": 1
	},
	{
		"text": "Hvilket stof i blodet transporterer ilt fra lungerne til kroppens væv?",
		"option_zero": "Hemoglobin",
		"option_one": "Plasma",
		"option_two": "Glukose",
		"option_three": "Hormoner",
		"correct": 0
	},
	{
		"text": "Hvad er den primære funktion af en vacuole i planteceller?",
		"option_zero": "At danne sporeorganer",
		"option_one": "At producere energi",
		"option_two": "At syntetisere proteiner",
		"option_three": "At opbevare vand og næringsstoffer",
		"correct": 3
	},
	{
		"text": "Hvilket væv forbinder muskler til knogler i kroppen?",
		"option_zero": "Tendoner",
		"option_one": "Ligamenter",
		"option_two": "Epitelvæv",
		"option_three": "Bruskvæv",
		"correct": 0
	},
	{
		"text": "Hvad kaldes den proces, hvorved organismer tilpasser sig deres miljø over tid?",
		"option_zero": "Evolution",
		"option_one": "Adaptation",
		"option_two": "Mutation",
		"option_three": "Genetik",
		"correct": 1
	},
	{
		"text": "Hvad er hovedfunktionen af en cellekerne i en eukaryot celle?",
		"option_zero": "At regulere cellemembranen",
		"option_one": "At syntetisere DNA",
		"option_two": "At opbevare genetisk materiale",
		"option_three": "At producere ATP",
		"correct": 2
	},
	{
		"text": "Hvilket organ i kroppen er ansvarligt for produktionen af insulin?",
		"option_zero": "Bugspytkirtlen",
		"option_one": "Leveren",
		"option_two": "Nyrerne",
		"option_three": "Milten",
		"correct": 0
	}
]


var exam=questions.slice(7,14)
var current_question_index=0
var answers=[4,4,4,4,4,4,4]
onready var text=$Paper/Question/Text
onready var zero=$Paper/Question/options/zero
onready var one=$Paper/Question/options/one
onready var two=$Paper/Question/options/two
onready var three=$Paper/Question/options/three
onready var previous=$Paper/previous
onready var next=$Paper/next
onready var give_button=$Paper/givein
onready var page_number=$Paper/numberLabel
onready var time_label=$Paper/timerlabel
onready var http : HTTPRequest = $HTTPRequest
var timer=0

var karaktere=[-3,0,2,4,7,10,12]



var new_profile := false
var information_sent := false
var profile := {
	"grade": {},
	"time": {}
}

func _ready():
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)
	AutoloadData.taking_test=true
	page_change()

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			new_profile = true
			print("404")
			return
		200:
			if information_sent:
				information_sent = false
				print("information sent")
			self.profile = result_body.fields

func update_question():
	text.text=exam[current_question_index].text
	zero.text=exam[current_question_index].option_zero
	one.text=exam[current_question_index].option_one
	two.text=exam[current_question_index].option_two
	three.text=exam[current_question_index].option_three
	zero.pressed=false
	one.pressed=false
	two.pressed=false
	three.pressed=false
	if (answers[current_question_index]>3):
		return
	if (answers[current_question_index]==0):
		zero.pressed=true
	elif (answers[current_question_index]==1):
		one.pressed=true
	elif (answers[current_question_index]==2):
		two.pressed=true
	else:
		three.pressed=true


func evaluate():
	print("*evaluate start")
	var score=0
	for i in range(7):
		if (answers[i]==exam[i].correct):
			score+=1
	if (!score==0):
		score-=1
	var finalScore=karaktere[score]
	AutoloadData.current_score=finalScore
	AutoloadData.current_time=stepify(timer, 1)
	AutoloadData.taking_test=false

	#profile.grades = { "integerValue": 1 }
	profile.grade = { "integerValue": finalScore }
	profile.time = { "integerValue": stepify(timer, 1) } # Erstat med variabel der holder værdien
	match new_profile:
		true:
			Firebase.save_document("users?documentId=%s" % Firebase.user_info.id, profile, http)
			print("document saved")
		false:
			Firebase.update_document("users/%s" % Firebase.user_info.id, profile, http)
			print("document updated")
	information_sent = true
	print("information sent")
	
	yield(get_tree().create_timer(2), "timeout")
	queue_free()

func _process(delta):
	timer+=delta
	time_label.text=str(stepify(timer, 1))
func page_change():
	page_number.text=str(current_question_index+1)+"."
	if (current_question_index==0):
		previous.hide()
	else:
		previous.show()
	
	if (current_question_index==6):
		give_button.show()
		next.hide()
	else:
		give_button.hide()
		next.show()
	update_question()
	
func _on_next_pressed():
	current_question_index+=1
	page_change()


func _on_previous_pressed():
	current_question_index-=1
	page_change()




func _on_zero_pressed():
	answers[current_question_index]=0
	one.pressed=false
	two.pressed=false
	three.pressed=false


func _on_one_pressed():
	answers[current_question_index]=1
	zero.pressed=false
	two.pressed=false
	three.pressed=false # Replace with function body.


func _on_two_pressed():
	answers[current_question_index]=2
	one.pressed=false
	zero.pressed=false
	three.pressed=false # Replace with function body.


func _on_three_pressed():
	answers[current_question_index]=3
	one.pressed=false
	two.pressed=false
	zero.pressed=false # Replace with function body.


func _on_givein_pressed():
	evaluate()
