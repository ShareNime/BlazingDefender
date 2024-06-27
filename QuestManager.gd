extends Node2D
signal onQuestAcceptedToStartGame
@onready var descriptionLabel : Label = %QuestDescription
@export var dummyQuest : Quest
var quest : Quest:
	set(value):
		quest = value
		if value.objective == "Fetch":
			descriptionLabel.text = "Find " + value.title
		elif value.objective == "Survive":
			print("This is Survine")
			DialogueManager.stopDialogue.emit()
			onQuestAcceptedToStartGame.emit()
			if(descriptionLabel):
				print("JALAN COY")
				descriptionLabel.text = value.description
			#%Label.text = "Protect Elenora From Enemies" 
			#%Label.text = value.title
			#%Test123.text = "ADASDAS"
			
			#descriptionLabel.text = "aaaaa";

func next_quest():
	DialogueManager.current_speaker.dialogue = quest.next_questline
	descriptionLabel.text = ""
func QuestCanvasHide():
	%CanvasQuestUI.hide()
func QuestCanvasShow():
	%CanvasQuestUI.show()
	
func reset():
	quest = dummyQuest
	QuestCanvasHide()
	descriptionLabel.text = ""
