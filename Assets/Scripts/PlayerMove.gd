extends State
class_name PlayerMove
@export var playerScript : PlayerScript
@export var animatedSprite : AnimatedSprite2D
@export var stepSFXPLayer : AudioStreamPlayer2D
const STEPSFXSOUND = preload("res://Assets/Music/step.mp3")
var stepSoundFrame = [2,5]
func Enter():
	print("Now in Moving State")
	animatedSprite.play("WalkRight")
	pass

func Exit():
	pass

func Update(_delta:float):
	if(playerScript.playerCurrHealth <= 0):
		Transitioned.emit(self, "Die")
	pass
func Move(inputDir):
	playerScript.velocity = inputDir * playerScript.playerCurrMoveSpeed
	playerScript.move_and_slide()
	
func PlayerFlip():
	if(playerScript.velocity.x > 0):
		playerScript.scale.x =  playerScript.scale.y * 1
	elif(playerScript.velocity.x < 0):
		playerScript.scale.x = playerScript.scale.y * -1
	pass
	
func Physics_Update(_delta : float):
	var inputDir = Input.get_vector("MoveLeft", "MoveRight","MoveTop", "MoveBot").normalized()
	Move(inputDir)	
	PlayerFlip()
	
	if(inputDir.length() <= 0):
		Transitioned.emit(self, "Idle")
	pass


func _on_animated_sprite_2d_frame_changed():
	if animatedSprite.animation == "WalkRight":
		if animatedSprite.frame in stepSoundFrame:
			print("Halo dari animated sprite frame cahnged")
			stepSFXPLayer.stream = STEPSFXSOUND
			stepSFXPLayer.play()
	pass # Replace with function body.
