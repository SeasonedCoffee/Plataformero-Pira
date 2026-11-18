extends Node2D
const ENEMY_SCENE = preload("res://src/scenes/Entities/Enemies/Idler.tscn")
@onready var enemigos: Node2D = $Enemigos
@onready var player: CharacterBody2D = $Player
@onready var marker_2d: Marker2D = $Checkpoints/Marker2D
@onready var marker_2d_2: Marker2D = $Checkpoints/Marker2D2
@onready var marker_2d_3: Marker2D = $Checkpoints/Marker2D3

var posicion_jugador: Vector2
var posiciones_iniciales: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Hud.show()
	AudioManager.play_music()
	GameManager.posicion_jugador = player.global_position

func checkpoint_1():
	GameManager.posicion_jugador = marker_2d.global_position

func checkpoint_2():
	GameManager.posicion_jugador = marker_2d_2.global_position

func checkpoint_3():
	GameManager.posicion_jugador = marker_2d_3.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		checkpoint_1()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		checkpoint_2()

func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		checkpoint_3()

func respawnear_enemigo(posicion: Vector2, tiempo_espera: float) -> void:
	await get_tree().create_timer(tiempo_espera).timeout
	var nuevo_enemigo = ENEMY_SCENE.instantiate()
	nuevo_enemigo.global_position = posicion
	enemigos.add_child(nuevo_enemigo)
