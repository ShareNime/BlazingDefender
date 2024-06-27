extends StaticBody2D
class_name Torch
@export var fireSprite : AnimatedSprite2D
@export var torchTimer : Timer
@export var countDownText : Label
@export var torchLight : PointLight2D
var maxSpriteAlphaValue : int = 255
var maxLightEnergyValue : float = 0.5
var minCountDownTimer : int = 75
var maxCountDownTimer : int = 120
var countDownTimerGet : int
var currSpriteAlphaValue : float = 0
var currLightEnergyValue : float = 0
var isLightUp : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	fireSprite = $Fire
	torchTimer = $Timer
	countDownText = $Label
	isLightUp = false
	fireSprite.modulate.a = 0
	torchLight.energy = 0
	pass # Replace with function body.

func StartTimer():
	countDownTimerGet = randi_range(minCountDownTimer,maxCountDownTimer)
	torchTimer.start(countDownTimerGet)
	isLightUp = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(torchTimer.time_left > 0):
		currSpriteAlphaValue = torchTimer.time_left / countDownTimerGet
		fireSprite.modulate.a = currSpriteAlphaValue
		currLightEnergyValue = (torchTimer.time_left / countDownTimerGet) * 0.5
		torchLight.energy = currLightEnergyValue
	pass
	countDownText.text = str(int(torchTimer.time_left))


func _on_timer_timeout():
	print(name , " is down")
	isLightUp = false
	pass # Replace with function body.


func _on_trigger_lit_area_mouse_shape_entered(_shape_idx):
	if !isLightUp:
		StartTimer()
	pass # Replace with function body.
