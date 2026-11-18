extends CanvasLayer
@onready var tiempo: Label = $PanelContainer/HBoxContainer/Tiempo
@onready var monedas: Label = $PanelContainer/HBoxContainer/Monedas
@onready var nivel: Label = $PanelContainer/HBoxContainer/Nivel
@onready var vidas: Label = $PanelContainer/HBoxContainer/Vidas


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("tiempo_actualizado", _on_time_actualizado)
	GameManager.connect("monedas_actualizadas", _on_monedas_actualizadas)
	GameManager.connect("nivel_actualizado", _on_nivel_actualizado)
	GameManager.connect("vidas_actualizadas", _on_vidas_actualizadas)
	
	#inicio las propiedades-------------------------------------->
	_on_nivel_actualizado(GameManager.nivel)
	_on_monedas_actualizadas(GameManager.monedas_recolectadas)
	_on_vidas_actualizadas(GameManager.vidas)

# Funciones para actualizar el HUD-------------------------->
func _on_time_actualizado(time: int) -> void:
	tiempo.text = "Tiempo: " + str(time)

func _on_monedas_actualizadas(coins: int) -> void:
	monedas.text = "Monedas Recolectadas: " + str(coins)

func _on_nivel_actualizado(level: int) -> void:
	nivel.text = "Nivel " + str(level)

func _on_vidas_actualizadas(lives: int) -> void:
	vidas.text = "Vidas restantes: " + str(lives)
