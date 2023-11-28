extends Node2D


onready var Questions=$Questions
onready var Question=$Questions/Question
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
		"option_one": "Nyrerne",
		"option_two": "Leveren",
		"option_three": "Maven",
		"correct": 1
	},
	{
		"text": "Hvad er funktionen af DNA i cellen?",
		"option_zero": "At danne energi",
		"option_one": "At lagre genetisk information",
		"option_two": "At syntetisere proteiner",
		"option_three": "At transportere næringsstoffer",
		"correct": 1
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
		"text": "Hvad er den primære funktion af en plantecelle-vacuole?",
		"option_zero": "At opbevare vand og næringsstoffer",
		"option_one": "At producere energi",
		"option_two": "At syntetisere proteiner",
		"option_three": "At danne sporeorganer",
		"correct": 0
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
	if (answers[current_question_index]==0):
		zero.pressed=true
	elif (answers[current_question_index]==1):
		one.pressed=true
	elif (answers[current_question_index]==2):
		two.pressed=true
	else:
		three.pressed=true
func _ready():
	print(exam)
	update_question()

func _process(delta):
	if (current_question_index==0):
		previous.hide()
	else:
		previous.show()
	
	if (current_question_index==6):
		next.hide()
	else:
		next.show()

func _on_next_pressed():
	current_question_index+=1
	update_question()


func _on_previous_pressed():

	current_question_index-=1
	update_question()




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
