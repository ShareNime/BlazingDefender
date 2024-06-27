extends State
class_name PlayerIdle
@export var playerScript : PlayerScript
@export var animatedSprite : AnimatedSprite2D

func Enter():
	print("Now in Idle State")
	animatedSprite.play("Idle")
	pass
	
func Exit():
	pass
	
func Update(delta : float):
	if(playerScript.playerCurrHealth <= 0):
		Transitioned.emit(self, "Die")
	if(Input.is_action_just_pressed("Attack")):
		Transitioned.emit(self,"Attack")
	if(Input.get_vector("MoveLeft", "MoveRight", "MoveBot", "MoveTop")):
		Transitioned.emit(self, "Move")
	if(Input.is_action_just_pressed("Interact") and playerScript.canInteract):
		Transitioned.emit(self, "Interact")
	pass
	
func Physics_Update(_delta : float):
	pass
