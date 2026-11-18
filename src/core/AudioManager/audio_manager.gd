extends Node

@onready var music: AudioStreamPlayer = $MUSIC/music
@onready var coin: AudioStreamPlayer = $SFX/coin
@onready var death: AudioStreamPlayer = $SFX/death
@onready var jump: AudioStreamPlayer = $SFX/jump
@onready var walljump: AudioStreamPlayer = $SFX/walljump
@onready var stomp: AudioStreamPlayer = $SFX/stomp
@onready var select: AudioStreamPlayer = $SFX/select
@onready var quit: AudioStreamPlayer = $SFX/quit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func play_music():
	music.play()

func stop_music():
	music.stop()

func play_coin():
	coin.play()

func play_death():
	death.play()

func play_jump():
	jump.play()

func play_walljump():
	walljump.play()

func play_stomp():
	stomp.play()

func play_select():
	select.play()

func play_quit():
	quit.play()
