extends Control


var dialogue : Dialogue:
	set(value):
		dialogue = value
		self.text = dialogue.path_option
		
func _on_pressed():
	if dialogue.options.size() == 0:
		DialogueManager.hide_dialogue()
		DialogueManager.stopDialogue.emit()
		return
		
	
	DialogueManager.dialogue = dialogue
	pass # Replace with function body.
	pass # Replace with function body.
	pass # Replace with function body.
