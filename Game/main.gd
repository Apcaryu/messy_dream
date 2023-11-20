extends Node

@onready var gui = $Gui
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Main scene is ready")
	gui.connect("play", play)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play():
	pass


func _on_timer_timeout():
	var gameover = $GameOver
	gameover.show()

func _input(event):
	if event.is_action_pressed("reload level"):
		get_tree().reload_current_scene()
