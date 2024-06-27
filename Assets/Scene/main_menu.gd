extends Control
var mainGame = load("res://Assets/Scene/PlayerScene/stage_1.tscn")
@export var settingScene : Control
func _on_play_pressed():
	get_tree().change_scene_to_packed(mainGame)
	pass # Replace with function body.


func _on_settings_pressed():
	settingScene.show()
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
