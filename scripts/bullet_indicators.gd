extends Node2D

@onready var player = get_parent()

func _physics_process(delta):
	update_bullet_indicators()

func update_bullet_indicators():
	if player.ammo > 0:
		for i in range(6):
			var indicator = get_child(i)
			indicator.stop()
			if i < player.ammo:
				indicator.frame = 0
			else:
				indicator.frame = 4
	
	if player.ammo == 0:
		for i in range(6):
			var indicator = get_child(i)
			indicator.play()


func _on_timer_timeout() -> void:
	player.ammo = 6
