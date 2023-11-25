extends RigidBody2D

signal touch

enum {
	IDLE_STATE,
	GRAB_STATE
}

enum {
	LIGHT,
	MEDIUM,
	HEAVY
}

var my_state = IDLE_STATE
var mouse_touch = false
var speed
var frame = 0
var processed_velocity = Vector2()
var processed_angular_velocity = Vector2()
var sound_emit = 5
var prev_pos
var actual_pos
var small_sounds = ["res://Sound/FX/petit1.mp3", "res://Sound/FX/petit2.mp3", "res://Sound/FX/petit3.mp3"]
var medium_sounds = ["res://Sound/FX/Moyen1.mp3", "res://Sound/FX/Moyen2.mp3", "res://Sound/FX/Moyen3.mp3"]
var heavy_sounds = ["res://Sound/FX/Fort1.mp3", "res://Sound/FX/Fort2.mp3", "res://Sound/FX/Fort3.mp3"]

@export var health = 1
@export var my_mass = LIGHT

func _ready():
	if mass < 25/3:
		my_mass = LIGHT
	elif mass < (25/3) * 2:
		my_mass = MEDIUM
	else:
		my_mass = HEAVY

func _physics_process(_delta):
	#speed = linear_velocity.length() * .01
	speed = linear_velocity.normalized()
	prev_pos = get_transform().origin	
	
func _integrate_forces(state):
	var diff = get_global_mouse_position() - get_global_position()
	var l_vec = get_linear_velocity()
	
	match my_state:
		GRAB_STATE:
			l_vec += diff / mass
	
	state.set_linear_velocity(l_vec)
	#speed = state.get_linear_velocity().length()

func _input(event):
	if event.is_action_pressed("grab") and mouse_touch:
		print("GRAB!")
		my_state = GRAB_STATE
	if event.is_action_released("grab"):
		my_state = IDLE_STATE

func _on_mouse_entered():
	#print("mouse_in")
	mouse_touch = true

func _on_mouse_exited():
	#print("mouse_out")
	mouse_touch = false

func _on_body_entered(_body):
	touch.emit()
	
	actual_pos = get_transform().origin
	var move = abs(prev_pos - actual_pos)
	
	if (move.x > sound_emit or move.y > sound_emit):
		var select_sound
		match my_mass:
			LIGHT:
				select_sound = small_sounds[randi_range(0, small_sounds.size() - 1)]
			MEDIUM:
				select_sound = medium_sounds[randi_range(0, medium_sounds.size() - 1)]
			HEAVY:
				select_sound = heavy_sounds[randi_range(0, heavy_sounds.size() - 1)]
		
		var sfx = load(select_sound)
		$AudioStreamPlayer.stream = sfx
		$AudioStreamPlayer.play()
	#print("Touch!")
	#damage(speed)

func damage(force):
	print("Force: ", force)
	force = round(force)
	if force > 1:
		health -= force
		if health <= 0:
			queue_free()

