extends KinematicBody2D


export (int) var speed = 25

export (int) var shy_distance = 30


func _ready():
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	var c = get_parent().get_node("Player")
	var direction = (c.position - position)
	if direction.length() > shy_distance:
		var motion = direction.normalized()  * speed * delta
		position += motion
		
	
	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
