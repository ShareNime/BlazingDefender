extends State
class_name PlayerDie

@export var animatedSprite : AnimatedSprite2D
@export var playerScript : PlayerScript
signal playerDieSignal

func Enter():
	animatedSprite.play("Die")
	pass

func Exit():
	pass

func Update(_delta:float):
	pass

func Physics_Update(_delta : float):
	pass

func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "Die":
		playerDieSignal.emit()
	pass # Replace with function body.
