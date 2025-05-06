extends TextureButton

var is_playing: bool = false

@onready var modal_you_win: PanelContainer = $"../../ModalYouWin"

@export var texture_play: CompressedTexture2D
@export var texture_pause: CompressedTexture2D

func _ready() -> void:
	EventBus.connect("play", _on_play)
	EventBus.connect("pause", _on_pause)
	EventBus.emit_signal("pause")

func _on_pressed() -> void:
	if is_playing:
		EventBus.emit_signal("pause")
	else:
		EventBus.emit_signal("play")

func _on_play() -> void:
	is_playing = true
	texture_normal = texture_pause
	EventBus.emit_signal("reset")

func _on_pause() -> void:
	is_playing = false
	texture_normal = texture_play
