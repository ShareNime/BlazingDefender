extends State
class_name GoblinIdle
@export var torchGoblinScript : TorchGoblinScript
@export var animatedSprite : AnimatedSprite2D


func Enter():
	
	print("Goblin in Idle State")
	animatedSprite.play("GoblinIdle")
	pass
	
func Exit():
	pass
	
func Update(delta : float):
	if torchGoblinScript.torchGoblinCurrHealth <= 0:
		Transitioned.emit(self, "Die")
	pass
	
func Physics_Update(_delta : float):
	pass


func _on_timer_timeout():
	if !torchGoblinScript.isWaveFinished:
		Transitioned.emit(self, "Move")
	pass # Replace with function body.
