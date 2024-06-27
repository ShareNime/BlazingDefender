extends State
class_name PlayerInteract

@export var playerScript : PlayerScript
@export var animatedSprite : AnimatedSprite2D

func Enter():
	playerScript.InteractToNpc.emit()
	DialogueManager.connect("stopDialogue",exitInteractState)
	print("This is Interact State")
	pass

func Exit():
	pass

func Update(_delta:float):
	pass

func exitInteractState():
	Transitioned.emit(self, "Idle")

func Physics_Update(_delta : float):
	pass
