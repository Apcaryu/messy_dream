extends CanvasLayer

signal play

#var score = 30
var new_texture = preload("res://Assets/Game+over.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_down():
	play.emit()
	$MarginContainer/NinePatchRect/Button.hide()
	hide()

func update_score(score):
	$MarginContainer/NinePatchRect/ScoreLabel.text = str(score)

func gameover():
	$MarginContainer/Titlescreen.texture = new_texture
	show()
	$MarginContainer/NinePatchRect/ScoreLabel.show()
