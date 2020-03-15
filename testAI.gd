extends KinematicBody2D

export (int) var speed = 25
export (int) var attack_distance = 120

var motion = Vector2()
var state = "IDLE"
var c
var can_Move = true

func _ready():
	$AnimationPlayer.play("Idle")


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
		ANGRY()
	elif state == "IDLE":
		IDLE()

	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.collider.name)
		if collision.collider.name == "Player":
			get_tree().change_scene("GAMEOVER.tscn")

func random():
    randomize()
    return randi()%21 - 10 # range is -10 to 10

func IDLE():
	$AnimationPlayer.play("Idle")
	check_dir()
	motion = move_and_slide(motion)

func ANGRY():
	$AnimationPlayer.play("Angry")
	var direction = (c.position - position)
	motion = direction.normalized()  * speed * 2
#	if motion.x > 0:
#		$Sprite.flip_h = true
#	if motion.x < 0:
#		$Sprite.flip_h = false
	check_dir()
	motion = move_and_slide(motion)

func set_State(i):
	state = i
	
func check_dir():
	if motion.x > 0:
		$Sprite.flip_h = true
	if motion.x < 0:
		$Sprite.flip_h = false

func _on_Timer_timeout():
	if(can_Move == false):
		can_Move = true
		motion = Vector2(random(), random()).normalized() * 20
	else:
		can_Move = false
