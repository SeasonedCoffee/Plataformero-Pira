extends Node
signal tiempo_actualizado(tiempo)
signal monedas_actualizadas(monedas)
signal nivel_actualizado(nivel)
signal vidas_actualizadas(vidas)
#signal nivel_completado

var tiempo: int = 0
#var monedas: int = 0
var vidas: int = 5
var nivel: int = 1
var posicion_jugador: Vector2
var tiempo_transcurrido: float = 0.0
var cronometro_activo: bool = true

#variable para recolectar monedas------------------------------------>
var monedas_recolectadas: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#seteando el nivel por primera vez
	emit_signal("monedas_actualizadas", monedas_recolectadas)
	emit_signal("vidas_actualizadas", vidas)
	emit_signal("nivel_actualizado", nivel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cronometro_activo:
		tiempo_transcurrido += delta
		emit_signal("tiempo_actualizado", int(tiempo_transcurrido))

func perder_vidas(vida):
	vidas = vida
#	print(vidas)
	emit_signal("vidas_actualizadas", vidas)

func recolectar_item() -> void:
	monedas_recolectadas += 1
	print(monedas_recolectadas)
	emit_signal("monedas_actualizadas", monedas_recolectadas)
	ganar()

#func agregar_monedas(valor: int) ->void:
#s	monedas += valor
#	emit_signal("monedas_actualizadas",monedas_recolectadas)

func ganar() -> void:
	if monedas_recolectadas == 11:
		print("gane")
		get_tree().change_scene_to_file("res://src/scenes/Ui/WinLose/WinLose.tscn")
		resetear_nivel()
		Hud.hide()
		AudioManager.stop_music()
	else:
		return

func perder() -> void:
	get_tree().change_scene_to_file("res://src/scenes/Ui/WinLose/WinLose.tscn")
	AudioManager.stop_music()
	pass

func resetear_nivel() -> void:
	monedas_recolectadas = 0
	vidas = 5
	tiempo_transcurrido = 0.0
	
	emit_signal("tiempo_actualizado", int(tiempo_transcurrido))
	emit_signal("monedas_actualizadas", monedas_recolectadas)
	emit_signal("vidas_actualizadas", vidas)
	emit_signal("nivel_actualizado", nivel)
