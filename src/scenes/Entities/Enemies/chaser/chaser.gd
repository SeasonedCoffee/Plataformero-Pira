extends CharacterBody2D

signal danio_al_player_chaser(cantidad, posicion_enemigo)

var jugador: Node2D = null
var direccion: Vector2 = Vector2(0,0)
var velocidad: float = 60.0

#variables del chaser
@export var danio: int = 1
@export var vida: int = 5
@export var puntos_enemigo: int = 10

func _physics_process(delta: float) -> void:
	if jugador:
		direccion = global_position.direction_to(jugador.global_position)
		velocity = direccion * velocidad
		move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		jugador = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == jugador:
		jugador = null


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("jugador entro en el area")
		get_tree().reload_current_scene()
		danio_al_player_chaser.emit(danio, global_position)




func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.velocity.y = -400
		queue_free()
