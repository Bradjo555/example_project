extends CharacterBody2D

var speed := 200.0
var gravity := 800.0 
var jump_force := -300.0  
var can_move := true  

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if not can_move:
		velocity.x = 0
		move_and_slide()
		return
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

	if Input.is_action_just_pressed("space") and is_on_floor():
		can_move = false
		animated_sprite.play("attack_1")
		velocity.x = 0 
		return 
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		animated_sprite.flip_h = direction < 0  
		animated_sprite.play("run")  
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animated_sprite.play("idle")  
	
	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "attack_1":
		can_move = true  
