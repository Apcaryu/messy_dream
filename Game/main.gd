extends Node

@onready var gui = $Gui
@onready var timer = $Timer
var meubles
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	meubles = get_tree().get_nodes_in_group("meubles")
	for i in meubles:
		i.connect("touch", touch)
	#print("Main scene is ready")
	gui.connect("play", play)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play():
	meubles = get_tree().get_nodes_in_group("meubles")	
	for i in meubles:
		i.contact_monitor = true
		i.input_pickable = true
	score = 0
	timer.start()

func touch():
	score += 1

func _on_timer_timeout():
	gui.update_score(score)
	gui.gameover()
	#var gameover = $GameOver
	#gameover.show()
	print("score = ", score)

func _input(event):
	if event.is_action_pressed("reload level"):
		get_tree().reload_current_scene()
