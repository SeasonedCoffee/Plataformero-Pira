extends CharacterBody2D

@export var SPEED: float = 200.0
@export var JUMP_VELOCITY: float = -400.0
@export var fuerza_salto_pared: Vector2 = Vector2(300.0, -350.0)

var doble_salto: int = 2
var ya_salto_en_pared: bool = false

var esta_en_pared: bool = false
var normal_pared: Vector2 = Vector2.ZERO


func aplicar_movimiento_y_animacion():
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	actualizar_animacion(direction)

func gravedad(delta):
	# Add the gravity.
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
			velocity.y = JUMP_VELOCITY
			doble_salto -= 1
		elif esta_en_pared and not ya_salto_en_pared:
			velocity.x = normal_pared.x * fuerza_salto_pared.x
			velocity.y = fuerza_salto_pared.y
			ya_salto_en_pared = true
		elif doble_salto > 0 and not esta_en_pared:
			velocity.y = JUMP_VELOCITY
			doble_salto -= 1

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
