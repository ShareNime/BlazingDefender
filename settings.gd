extends Control

@export var settingScene : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sfx_volume_value_changed(value):
	pass # Replace with function body.


func _on_bgm_volume_value_changed(value):
	pass # Replace with function body.


func _on_bgm_slider_value_changed(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)	
	pass # Replace with function body.


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	pass # Replace with function body.


func _on_button_pressed():
	settingScene.hide()
	pass # Replace with function body.
