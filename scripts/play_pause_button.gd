extends TextureButton

var is_playing: bool = false

@onready var modal_you_win: PanelContainer = $"/root/Game/UI/ModalYouWin"

@export var texture_play: CompressedTexture2D
@export var texture_pause: CompressedTexture2D

signal play
signal pause

func _ready() -> void:
	emit_signal("pause")

func _on_pressed() -> void:
	if is_playing:
		emit_signal("pause")
	else:
		emit_signal("play")

func _on_play() -> void:
	is_playing = true
	texture_normal = texture_pause
	modal_you_win.emit_signal("reset")

func _on_pause() -> void:
	is_playing = false
	texture_normal = texture_play
