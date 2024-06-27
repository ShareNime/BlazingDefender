extends Stage

@export var safeZoneCamera : Camera2D
@export var dangerZoneCamera : Camera2D
@export var spawnPositionArray : Array[Path2D]
@export var eleonoraHealthBar : TextureProgressBar
@export var enemyScene : PackedScene
@export var torches : Array[Torch]
@export var timeCounterLabel : Label
@export var alertLabel : Label
@export var gateAttackedTimer : Timer
@export var BGM_Player : AudioStreamPlayer2D
@export var torchAudioPlayer : AudioStreamPlayer2D
@export var settingUI : Control


const WAVESTARTBGM = preload("res://Assets/Music/BGMWave.mp3")
const IDLEBGM = preload("res://Assets/Music/BGMIdle.mp3")
var isGameRunning : bool = false
var isStageOneFinished = false
var maxGateHealth : int = 5
var currGateHealth : int
var spawnTime : int = 10

var changeSceneTo : PackedScene;
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.reset()
	QuestManager.reset()
	QuestManager.connect("onQuestAcceptedToStartGame",GameStart)
	DialogueManager.connect("changeSceneSignal",changeScene)
	#$StageFinishAnim.play("WaveCompleteAnimation")
	print(spawnPositionArray.size())
	GameIdle()
	BGM_Player.stream = IDLEBGM
	BGM_Player.play()
	#safeZoneCamera.enabled = true
	#dangerZoneCamera.enabled = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#for torch in torches:
		#if !torch.isLightUp:
			#gameTimer.paused = true
			#print("Ada Torch Yang Ga Nyala LINE 27")
	if torches.all(isLightUp):
		gameTimer.paused = false
		torchAudioPlayer.volume_db = 18
		alertLabel.hide()
	else:
		gameTimer.paused = true
		torchAudioPlayer.volume_db = 0
		if(isGameRunning):
			alertLabel.show()
	pass
	timeCounterLabel.text = str(int(gameTimer.time_left))
	#if Input.is_action_just_pressed("Attack"):
		#GameOver()
func _unhandled_input(event):
	if event.is_action_pressed("OpenSetting"):
		settingUI.visible = !settingUI.visible
func changeScene(scene : PackedScene):
	$CanvasLayer/StageFinishAnim.play("NextStageAnim")
	changeSceneTo = scene
	
func GameStart():
	print("GAME STARTEDDDDD!!!!")
	BGM_Player.stream = WAVESTARTBGM
	BGM_Player.play()
	gameTimer.start()
	timeCounterLabel.text = str(int(gameTimer.time_left))
	startSpawnTimer()
	isGameRunning = true
	$Interactable/MageNPC.WaveStartPhase()
	
func GameIdle():
	currGateHealth = maxGateHealth
	eleonoraHealthBar.max_value = maxGateHealth
	isGameRunning = false
	$Interactable/MageNPC.GameIdlePhase()
	BGM_Player.stream = IDLEBGM
	BGM_Player.play()
	
func WaveFinished():
	isStageOneFinished = true;
	spawnTimer.stop()
	print("You Win!")
	QuestManager.QuestCanvasHide()
	StageManager.currentStage += 1
	for path in spawnPositionArray:
			for enemy in path.get_children():
				if enemy is TorchGoblinScript:
					enemy.isWaveFinished = true
					print("ENEMY NAME : " , enemy.name)
	$CanvasLayer/StageFinishAnim.play("WaveCompleteAnimation")
	if QuestManager.quest != null:
		QuestManager.next_quest()
	
func GameOver():
	spawnTimer.stop()
	gameTimer.stop()
	isGameRunning = false
	print("GAME OVER")
	$CanvasLayer/StageFinishAnim.play("PlayerDefeatAnim")
	
func startSpawnTimer():
	spawnTimer.start(spawnTime)
	
func _on_change_camera_zone_body_exited(body):
	if body.is_in_group("Player"):
		print("Player Change Zone")
		safeZoneCamera.enabled = !safeZoneCamera.enabled
		dangerZoneCamera.enabled = !dangerZoneCamera.enabled
	pass # Replace with function body.
func isLightUp(value : Torch):
	return value.isLightUp

func gateDamaged(value : int):
	if currGateHealth > 0:
		currGateHealth -= value
		eleonoraHealthBar.value = currGateHealth
		$CanvasLayer/DamagedPopup.show()
		gateAttackedTimer.wait_time = 0.2
		gateAttackedTimer.start()
	if currGateHealth <= 0:
		GameOver()

func _on_safe_zone_enter_body_entered(body):
	if body.is_in_group("Player"):
		safeZoneCamera.enabled = true
		dangerZoneCamera.enabled = false
	pass # Replace with function body.


func _on_danger_zone_enter_body_entered(body):
	if body.is_in_group("Player"):
		safeZoneCamera.enabled = false
		dangerZoneCamera.enabled = true
	if body.is_in_group("Enemy"):
		gateDamaged(1)
	pass # Replace with function body.


func _on_spawn_timer_timeout():
	var monster = enemyScene.instantiate()
	var randomIndex :int = randi_range(0, spawnPositionArray.size()-1)
	print(randomIndex)
	spawnPositionArray[randomIndex].add_child(monster)
	pass # Replace with function body.

func _on_game_timer_timeout():
	if(currGateHealth > 0):
		WaveFinished()
	else:
		GameOver()
	spawnTimer.stop()
	pass # Replace with function body.


func _on_stage_finish_anim_animation_finished(anim_name):
	if anim_name == "WaveCompleteAnimation":
		isGameRunning = false
		for path in spawnPositionArray:
			for enemy in path.get_children():
				if enemy is TorchGoblinScript:
					enemy.torchGoblinCurrHealth -= 10000
					print("ENEMY NAME : " , enemy.name)
		GameIdle()
	if anim_name == "PlayerDefeatAnim":
		DialogueManager.reset()
		QuestManager.reset()
		get_tree().reload_current_scene()
	if anim_name == "NextStageAnim":
		get_tree().change_scene_to_packed(changeSceneTo)
		pass
	pass # Replace with function body.


func _on_player_player_die_signal():
	GameOver()
	pass # Replace with function body.


func _on_gate_attacker_timer_timeout():
	$CanvasLayer/DamagedPopup.hide()
	pass # Replace with function body.

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Assets/Scene/main_menu.tscn")
	pass # Replace with function body.
