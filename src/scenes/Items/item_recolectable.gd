extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var puntos: int

var recolectado: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("default")



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		AudioManager.play_coin()
		print("entro el jugador")
		GameManager.recolectar_item()
#		GameManager.agregar_monedas(puntos)
		queue_free()
