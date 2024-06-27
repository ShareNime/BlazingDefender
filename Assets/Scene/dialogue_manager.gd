extends Node2D

@export var next_button : PackedScene
@export var quest_button : PackedScene
signal stopDialogue
signal changeSceneSignal(changeSceneTo : PackedScene)
var current_speaker = null
var dialogue : Dialogue:
	set(value):
		dialogue = value
		if current_speaker:
			current_speaker.dialogue = value
		%Icon.texture = value.texture
		%Name.text = value.name
		%Dialogue.text = value.dialogue
		print("DO SMOHITGN : " , dialogue.doSomething)
		if dialogue.doSomething == "ChangeScene":
			hide_dialogue()
			stopDialogue.emit()
			changeSceneSignal.emit(dialogue.changeSceneTo)
			print("EMIT CHANGE SCENE")
		reset_options()
		
		print(value.quest)
		
		if value.quest:
			add_quest(value.quest)
			print("ADA QUEST")
		add_buttons(value.options)
		
		#await get_tree().create_timer(0.5).timeout
		%Options.show()
func _ready():
	#dialogue = load("res://Assets/NPCs/Eleonore/Dialogues/0.tres")
	pass

func reset_options():
	for child in %Options.get_children():
		child.queue_free()
	%Options.hide()

func add_buttons(options):
	for option in options:
		var button = next_button.instantiate()
		button.dialogue = option
		%Options.add_child(button)

func hide_dialogue():
	%UI.hide()
func show_dialogue():
	%UI.show();
func add_quest(quest):
	if QuestManager.quest == quest:
		return
	var button = quest_button.instantiate()
	button.quest = quest
	%Options.add_child(button)
	print("masuk button quest")
func reset():
	# Reset the dialogue-related variables
	#dialogue = null
	
	current_speaker = null
	%Icon.texture = null
	%Name.text = ""
	%Dialogue.text = ""
	# Hide and clear options
	reset_options()
	# Hide the UI
	hide_dialogue()
