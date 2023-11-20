extends RigidBody2D

enum {
	IDLE_STATE,
	GRAB_STATE
}

var my_state = IDLE_STATE
var mouse_touch = false
var speed
var frame = 0
var processed_velocity = Vector2()
var processed_angular_velocity = Vector2()

@export var health = 100

func _physics_process(_delta):
	speed = linear_velocity.length() * .01
	
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
	pass
	#print("Touch!")
	#damage(speed)

func damage(force):
	print("Force: ", force)
	force = round(force)
	if force > 1:
		health -= force
		if health <= 0:
			queue_free()
