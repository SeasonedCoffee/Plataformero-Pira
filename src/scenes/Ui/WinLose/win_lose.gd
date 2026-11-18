extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_jugar_pressed() -> void:
	AudioManager.play_select()
	get_tree().change_scene_to_file("res://src/scenes/Levels/Level/level1.tscn")

func _on_salir_pressed() -> void:
	AudioManager.play_quit()
	get_tree().quit()
