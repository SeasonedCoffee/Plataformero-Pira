extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.stop_music()



func _on_back_pressed() -> void:
	AudioManager.play_quit()
	get_tree().change_scene_to_file("res://src/scenes/Ui/Menu/Menu.tscn")
