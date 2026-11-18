extends Area2D
signal danio_al_player(danio)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var danio: int = 1
var posicion_inicial: Vector2


func _ready() -> void:
	animated_sprite_2d.play("default")
	posicion_inicial = global_position

#la hitbox del enemigo, si el player la toca, muere------------------------------------>
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.recibir_danio(danio)
		body.global_position = GameManager.posicion_jugador
#		danio_al_player.emit(danio)
#		get_tree().reload_current_scene()

#el area que el jugador tiene para saltar en el enemigo y matarlo----------------------->
func _on_hurtbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		AudioManager.play_stomp()
		body.velocity.y = -400
		var nivel = get_tree().current_scene
		if nivel.has_method("respawnear_enemigo"):
			nivel.respawnear_enemigo(posicion_inicial, 3.0)
		queue_free()
