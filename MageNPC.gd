extends RigidBody2D

signal playerEnter(value : bool)
@export var dialogue : Dialogue
var normalTextContainer : Control
var IdlePhaseLabel : Label
var WaveStartLabel : Label
var isInteractable : bool = false
var isInteracted : bool = false
var isPlayerStay : bool = false
var cheerText : String = "Stay strong, Adventurer! We're almost there!"
var playerNode : Node
# Called when the node enters the scene tree for the first time.
func _ready():
	normalTextContainer = $NormalTextContainer
	IdlePhaseLabel = $NormalTextContainer/IdlePhase
	WaveStartLabel = $NormalTextContainer/WaveStartPhase
	IdlePhaseLabel.text = "!"
	WaveStartLabel.text = cheerText
	playerNode = $"../Player"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func WaveStartPhase():
	IdlePhaseLabel.hide()
	WaveStartLabel.show()
	isInteractable = false
	pass

func Interacted():
	print("Start Interacttttt")
	DialogueManager.dialogue = dialogue;
	DialogueManager.current_speaker = self
	DialogueManager.show_dialogue()

func GameIdlePhase():
	IdlePhaseLabel.show()
	WaveStartLabel.hide()
	isInteractable = true
	pass

func _on_trigger_area_body_entered(body):
	if body.is_in_group("Player"):
		normalTextContainer.visible = true
		isPlayerStay = true
		if isInteractable:
			playerEnter.emit(true)
	pass # Replace with function body.


func _on_trigger_area_body_exited(body):
	if body.is_in_group("Player"):
		isPlayerStay = false
		normalTextContainer.visible = false
		playerEnter.emit(false)
	pass # Replace with function body.


func _on_player_interact_to_npc():
	if(isPlayerStay):
		print("ADADADADADA")
		Interacted()
	pass # Replace with function body.
