extends CharacterBody2D

var speed : int
var screen_size : Vector2
var angle_radians : float
var angle_normalized : int
@export var ammo: int

func _ready():
	speed = 100
	screen_size = get_viewport_rect().size
	ammo = 4

func get_input():
	var walk_direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	velocity = walk_direction.normalized() * speed
	
	var view_direction = Input.get_vector("view_left", "view_right", "view_up", "view_down")
	if view_direction != Vector2.ZERO:
		var view_angle = 8*snappedf(view_direction.angle(), PI/4) / PI/4
		print(view_angle)
		var view_angle_0_to_8 = wrapi(int(view_angle), 0, 8)
		$AnimatedSprite2D.animation = "walk" + str(view_angle_0_to_8)
	
	if Input.is_action_pressed("shoot"):
		shoot()
	
	if ammo == 0:
		$Timer.start()

func shoot():
	ammo = ammo - 1
	

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
