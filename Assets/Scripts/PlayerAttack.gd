extends State

class_name PlayerAttack

@export var playerScript : PlayerScript
@export var animatedSprite : AnimatedSprite2D
@export var hurtBoxAttack : CollisionShape2D
@export var attackSFX : AudioStreamPlayer2D
const SWORDSLASHNOTHING = preload("res://Assets/Music/swordswing.mp3")
const SWORDHITENEMY = preload("res://Assets/Music/swordhit.mp3")
signal giveDamage(damage : int)
var attackHitFrame = 3
func Enter():
	
	if playerScript.playerCurrCombo == 1:
		animatedSprite.play("AttackRight1")
		print("Attack 1")
	if playerScript.playerCurrCombo == 2:
		animatedSprite.play("AttackRight2")
		print("Attack 2")
	if(playerScript.playerCurrCombo < 2):
		playerScript.playerCurrCombo += 1
	else:
		playerScript.playerCurrCombo = 1
	pass
	
func Exit():
	$"../AttackComboTimer".start()
	pass

func Update(_delta:float):
	if playerScript.playerCurrHealth <= 0:
		Transitioned.emit(self, "Die")
	pass

func Physics_Update(_delta : float):
	pass

func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "AttackRight1" or animatedSprite.animation == "AttackRight2":
		hurtBoxAttack.disabled = true
		Transitioned.emit(self, "Idle")
	pass # Replace with function body.


func _on_attack_collision_body_entered(body):
	if(body.is_in_group("Enemy")):
		if body.get_parent() is TorchGoblinScript:
			body.get_parent().EnemyTakeDamage(playerScript.playerAttackDamage)
		print("Hit an Enemy From Attack State")
		attackSFX.stream = SWORDHITENEMY
		attackSFX.play()
	pass # Replace with function body.


func _on_animated_sprite_2d_sprite_frames_changed():
	if animatedSprite.animation == "AttackRight1" or animatedSprite.animation == "AttackRight2":
		if animatedSprite.frame == attackHitFrame:
			
			hurtBoxAttack.disabled = false
	pass # Replace with function body.


func _on_animated_sprite_2d_frame_changed():
	if animatedSprite.animation == "AttackRight1" or animatedSprite.animation == "AttackRight2":
		if animatedSprite.frame == attackHitFrame:
			print("Halo dari animated sprite frame cahnged")
			hurtBoxAttack.disabled = false
			attackSFX.stream = SWORDSLASHNOTHING
			attackSFX.play()
	pass # Replace with function body.
