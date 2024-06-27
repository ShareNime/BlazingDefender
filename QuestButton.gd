extends Button


var quest : Quest:
	set(value):
		quest = value
		text = value.title + " [Quest]"


func _on_pressed():
	QuestManager.quest = quest
	DialogueManager.hide_dialogue()
	QuestManager.QuestCanvasShow()
	queue_free()
	pass # Replace with function body.
