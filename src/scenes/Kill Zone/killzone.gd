extends Area2D
var danio: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.recibir_danio(danio)
		body.global_position = GameManager.posicion_jugador
#		get_tree().reload_current_scene()
