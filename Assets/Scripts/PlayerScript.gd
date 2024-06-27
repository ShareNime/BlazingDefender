extends CharacterBody2D
class_name PlayerScript

var playerHealth : int = 100
var playerCurrHealth : int
var playerMoveSpeed : float = 150
var playerCurrMoveSpeed : float
var playerAttackDamage : int = 50
var playerCurrCombo : int = 1
var canInteract : bool = false
@export var attackedTimer : Timer
@export var healthBarSlider : TextureProgressBar
signal InteractToNpc
signal playerDieSignal
func _ready():
	
	PlayerInit()

func PlayerInit():
	healthBarSlider.max_value = playerHealth
	healthBarSlider.value = playerHealth
	playerCurrMoveSpeed = playerMoveSpeed
	playerCurrHealth = playerHealth

func PlayerTakeDamage(damage : int):
	if playerCurrHealth > 0:
		playerCurrHealth -= damage
		healthBarSlider.value = playerCurrHealth
		print("Player Curr Health: ", playerCurrHealth )
		$CanvasLayer/DamagedPopup.show()
		attackedTimer.wait_time = 0.2
		attackedTimer.start()
		
func _process(delta):
	pass

func _on_attack_combo_timer_timeout():
	print("Player Combo Reset")
	playerCurrCombo = 1
	pass # Replace with function body.


func _on_die_player_die_signal():
	#queue_free()
	playerDieSignal.emit()
	hide()
	print("Player Gone")
	pass # Replace with function body.

func _on_mage_npc_player_enter(value):
	if value:
		print("Player Masuk")
	else:
		print("Player Keluar")
	canInteract = value
	print(canInteract)
	pass # Replace with function body.


func _on_attacked_timer_timeout():
	$CanvasLayer/DamagedPopup.hide()
	pass # Replace with function body.
