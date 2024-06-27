extends State
class_name GoblinAttack
@export var torchGoblinScript : TorchGoblinScript
@export var animatedSprite : AnimatedSprite2D
@export var enemyAttackBox : CollisionShape2D
@export var attackSFXPlayer : AudioStreamPlayer2D
const BLUNTHITNOTHING = preload("res://Assets/Music/swordswing.mp3")
const BLUNTHITPLAYER = preload("res://Assets/Music/blunthit.mp3")
var enemyEnableBoxFrame = 3
func Enter():
	print("Goblin in Attack State")
	attackSFXPlayer.stream = BLUNTHITNOTHING
	attackSFXPlayer.play()	
	animatedSprite.play("GoblinAttack")
	pass
	
func Exit():
	pass
	
func Update(delta : float):
	if torchGoblinScript.torchGoblinCurrHealth <= 0:
		Transitioned.emit(self, "Die")
	if torchGoblinScript.isWaveFinished:
		Transitioned.emit(self, "Idle")
	pass
	
func Physics_Update(_delta : float):
	pass


func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "GoblinAttack":
		Transitioned.emit(self, "Move")
		enemyAttackBox.disabled = true
	pass # Replace with function body.


func _on_enemy_attack_box_body_entered(body):
	if body.is_in_group("Player"):
		if body is PlayerScript:
			body.PlayerTakeDamage(torchGoblinScript.torchGoblinAttackDamage)
			attackSFXPlayer.stream = BLUNTHITPLAYER
			attackSFXPlayer.play()
	pass # Replace with function body.


func _on_animated_sprite_2d_frame_changed():
	if animatedSprite.animation == "GoblinAttack":
		if animatedSprite.frame == enemyEnableBoxFrame:
			enemyAttackBox.disabled = false
	pass # Replace with function body.
