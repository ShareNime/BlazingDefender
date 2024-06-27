extends State
class_name GoblinDie
@export var torchGoblinScript : TorchGoblinScript
@export var animatedSprite : AnimatedSprite2D

func Enter():
	print("Goblin in Die State")
	animatedSprite.play("GoblinDie")
	pass
	
func Exit():
	pass
	
func Update(delta : float):
	
	pass
	
func Physics_Update(_delta : float):
	pass


func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "GoblinDie":
		torchGoblinScript.queue_free()
	pass # Replace with function body.
