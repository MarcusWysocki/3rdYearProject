extends KinematicBody2D

export (int) var idle_speed = 0
export (int) var attack_speed = 21
export (int) var attack_distance = 120
export (String) var home_name = "None"

var motion = Vector2() #Initialize mob movement
var state = "IDLE" #Initialize mob state
var c #Initialize reference for player character
var can_Move = true 
const TIME_PERIOD = 1
var angry_sound = false
var at_home = true
var home

func _ready():
	$AnimationPlayer.play("Idle")
	if home_name != "None":
		home = get_parent().get_node(home_name)

# warning-ignore:unused_argument
func _process(delta):
	c = get_parent().get_node("Player")
	
	if c.get_safety() == true:
		set_State("IDLE")
	elif c.get_safety() == false:		
		if (c.position - position).length() < attack_distance:
			set_State("ANGRY")
		else:
			set_State("IDLE")
			
	if state == "ANGRY":
		$AnimationPlayer.play("Angry")
		if angry_sound == false:
			growl_sound()
		ANGRY()
		
	elif state == "IDLE":
		angry_sound = false
		IDLE()

	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.collider.name)
		if collision.collider.name == "Player":
			if c.get_safety() == false:
# warning-ignore:return_value_discarded
				get_tree().change_scene("GAMEOVER.tscn")

func random():
    randomize()
    return randi()%21 - 10 # range is -10 to 10

#How Ghost plays in Idle state
func IDLE():
	if at_home == false:
		var direction = (home.position - position)
		motion = direction.normalized() * idle_speed
	$AnimationPlayer.play("Idle")
	check_dir()
	motion = move_and_slide(motion)

#How Ghost plays in Angry state
func ANGRY():
	var direction = (c.position - position)
	motion = direction.normalized()  * attack_speed * 3
	check_dir()
	motion = move_and_slide(motion)

func set_State(i):
	state = i
	
func check_dir():
	if motion.x > 0:
		$Sprite.flip_h = true
	if motion.x < 0:
		$Sprite.flip_h = false

func growl_sound():
	var sound = get_node("AngryGrowl")
	sound.play()
	angry_sound = true

func _on_Timer_timeout():
	if(can_Move == false):
		can_Move = true
		motion = Vector2(random(), random()).normalized() * idle_speed
	else:
		can_Move = false


func _on_HomeChecker_area_entered(area):
	if area.name == home_name:
		at_home = true


func _on_HomeChecker_area_exited(area):
	print(area.name)
	if area.name == home_name:
		at_home = false
