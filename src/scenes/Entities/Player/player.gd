extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $Sprite2D

@export var SPEED: float = 175.0
@export var JUMP_VELOCITY: float = -300.0
@export var fuerza_salto_pared: Vector2 = Vector2(500.0, -600.0)
@export var tiempo_de_bloqueo: float = 0.15
#stats del player---------------------------------------------->
@export var vida: int = 5
@export var doble_salto: int = 2

# creo un timer para bloquear el movimiento
var ya_salto_en_pared: bool = false
var esta_en_pared: bool = false
var normal_pared: Vector2 = Vector2.ZERO
var temporizador_bloqueo: float = 0.0 # aca esta mi timer


func _physics_process(delta: float) -> void:
	#Reducimos el temporizador en cada frame si está activo
	if temporizador_bloqueo > 0:
		temporizador_bloqueo -= delta

	gravedad(delta)
	salto()
	aplicar_movimiento_y_animacion()
	move_and_slide()

func aplicar_movimiento_y_animacion():
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# SI EL BLOQUEO ESTÁ ACTIVO, ignoramos el teclado para que el impulso diagonal mande libremente
	if temporizador_bloqueo <= 0:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	actualizar_animacion(direction)

func actualizar_animacion(direction):
	if direction == 0:
		anim.play("idle")
	else:
		anim.play("run")
	
	if not is_on_floor():
		if velocity.y < 0:
			anim.play("salto")
		else:
			anim.play("aterrizaje")

	if direction < 0:
		anim.flip_h = true
	elif direction > 0:
		anim.flip_h = false

func gravedad(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func salto():
	esta_en_pared = is_on_wall() and not is_on_floor()
	normal_pared = get_wall_normal()

	if is_on_floor():
		doble_salto = 2
		ya_salto_en_pared = false

	if Input.is_action_just_pressed("saltar"):
		if is_on_floor():
			AudioManager.play_jump()
			velocity.y = JUMP_VELOCITY
			doble_salto -= 1
		elif esta_en_pared and not ya_salto_en_pared:
			AudioManager.play_walljump()
			# misma cuenta para el movimiento diagonal que para el salto normal, pero con la fuerza de salto en x y y
			velocity.x = normal_pared.x * fuerza_salto_pared.x
			velocity.y = fuerza_salto_pared.y
			ya_salto_en_pared = true
			doble_salto = 1 
			
			# BLOQUEAMOS EL TECLADO por 0.15 segundos para que no frene el impulso diagonal
			temporizador_bloqueo = tiempo_de_bloqueo 
			
		elif doble_salto > 0 and not esta_en_pared:
			AudioManager.play_jump()
			velocity.y = JUMP_VELOCITY
			doble_salto -= 1

func recibir_danio(danio):
	AudioManager.play_death()
	vida -= danio
	GameManager.perder_vidas(vida)
	
	if vida <= 0:
		print("perdi")
		GameManager.perder()
		queue_free()
