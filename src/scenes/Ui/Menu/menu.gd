extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Hud.hide()
	AudioManager.stop_music()


func _on_jugar_pressed() -> void:
	AudioManager.play_select()
	get_tree().change_scene_to_file("res://src/scenes/Levels/Level/level1.tscn")

func _on_creditos_pressed() -> void:
	AudioManager.play_select()
	get_tree().change_scene_to_file("res://src/scenes/Ui/Credits/Credits.tscn")
