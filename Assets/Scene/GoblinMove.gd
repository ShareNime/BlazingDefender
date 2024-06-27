extends State
class_name GoblinMove
@export var torchGoblinScript : TorchGoblinScript
@export var animatedSprite : AnimatedSprite2D
var player
@export var enemyBody : RigidBody2D
var previousPosition : Vector2
var currPosition : Vector2
@export var enemyAttackBox : Area2D
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animatedSprite.play("GoblinWalking")
	print("Goblin in Move State")
	previousPosition = enemyBody.global_position
	pass
	
func Exit():
	pass
	
func Update(delta : float):
	GoblinFlip()
	if torchGoblinScript.progress_ratio == 1:
		torchGoblinScript.queue_free()
	if torchGoblinScript.torchGoblinCurrHealth <= 0:
		Transitioned.emit(self, "Die")
	pass
	
func GoblinFlip():
	if(currPosition.x > previousPosition.x):
		animatedSprite.flip_h = false;
	elif(currPosition.x < previousPosition.x):
		animatedSprite.flip_h = true;
	pass
	
func Physics_Update(delta : float):
	previousPosition = enemyBody.global_position
	if player:
		var direction = player.global_position - enemyBody.global_position
		if direction.length() < 50:
			if player.global_position.x > enemyBody.global_position.x:
				animatedSprite.flip_h = false
				enemyAttackBox.position = torchGoblinScript.facingRightAttackBox
				#enemyBody.apply_scale(Vector2(1,1))
			else:
				animatedSprite.flip_h = true
				enemyAttackBox.position = torchGoblinScript.facingLeftAttackBox
				#enemyBody.apply_scale(Vector2(-1,1))
			if !torchGoblinScript.isWaveFinished:
				Transitioned.emit(self, "Attack")
	else:
		print("Player Gone")
	if torchGoblinScript.isWaveFinished:
		Transitioned.emit(self, "Idle")
	
	torchGoblinScript.progress += torchGoblinScript.torchGoblinCurrMoveSpeed * delta
	currPosition = enemyBody.global_position
	
	pass
