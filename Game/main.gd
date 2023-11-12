extends Node

@onready var gui = $Gui
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	gui.connect("play", play)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play():
	pass


func _on_timer_timeout():
	var gameover = $GameOver
	gameover.show()
