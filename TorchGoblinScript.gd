extends PathFollow2D
class_name TorchGoblinScript

var torchGoblinHealth : int = 100
var torchGoblinCurrHealth : int
var torchGoblinMoveSpeed : float = 50
var torchGoblinCurrMoveSpeed : float
var torchGoblinAttackDamage : int = 10
var isGoblinCanMove : bool = true
var isWaveFinished : bool = false

var facingRightAttackBox : Vector2 = Vector2(40,0)
var facingLeftAttackBox : Vector2 = Vector2(-50,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	EnemyInit()
	pass # Replace with function body.

	

func EnemyInit():
	torchGoblinCurrMoveSpeed = torchGoblinMoveSpeed
	torchGoblinCurrHealth = torchGoblinHealth
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func EnemyTakeDamage(damage):
	if torchGoblinCurrHealth > 0:
		torchGoblinCurrHealth -= damage
		print("Torch Goblin Curr Health: " , torchGoblinCurrHealth)
