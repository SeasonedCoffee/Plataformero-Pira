extends CharacterBody2D

#Defino señal y paso informacion que va a usar otra escena
signal danio_al_player(cantidad, posicion_enemigo)

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var distancia: float = 50.0
var direccion_inicial: int = 1
var velocidad: float = 50.0
var posicion_inicial_en_x: float
var direccion_actual: int

#variables para mi enemigo
@export var danio: int = 1
@export var vida: int = 5
@export var puntos_enemigo: int = 10

func _ready() -> void:
	posicion_inicial_en_x = global_position.x
	direccion_actual = direccion_inicial

func _physics_process(delta: float) -> void:
	gravedad_patroller(delta)
	movimiento_patroller()
	move_and_slide()

func movimiento_patroller():
	chequeo_de_distancia()
	actualizar_animaciones(direccion_actual)
	velocity.x = direccion_actual * velocidad
#revisar la distancia recorrida---------------------->
func chequeo_de_distancia():
	if abs(global_position.x - posicion_inicial_en_x) >= distancia:
		direccion_actual *= -1

#gravedad del enemigo
func gravedad_patroller(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

#cambio de animaciones------------------------------->
func actualizar_animaciones(direccion):
	anim.play("run")
	if direccion > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("jugador entro en el area")
		get_tree().reload_current_scene()
		danio_al_player.emit(danio, global_position)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	if body.is_in_group("player"):
		body.velocity.y = -300
		queue_free()
