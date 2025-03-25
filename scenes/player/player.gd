extends CharacterBody2D

var speed := 200.0
var gravity := 800.0 
var jump_force := -300.0  

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		animated_sprite.flip_h = direction < 0  
		animated_sprite.play("run")  
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animated_sprite.play("idle")  
	
	move_and_slide()
