extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var chaser: CharacterBody2D = $Enemigos/Chaser
@onready var patroller: CharacterBody2D = $Enemigos/patroller


func _ready() -> void:
	patroller.danio_al_player.connect(player.recibir_danio)
