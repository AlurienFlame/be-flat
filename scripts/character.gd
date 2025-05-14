class_name Character extends RigidBody2D

@onready var play_pause_button: TextureButton = $"/root/SceneManager/UI/MenuBar/PlayPauseButton"

@onready var start_position: Vector2 = position

# We use this flag to track if, on the next iteration of the physics engine,
# we should move the character back to the start position and reset the flag
var should_reset: bool = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Runs as part of the physics engine
	if (should_reset):
		state.transform = Transform2D(0, start_position)
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0.0
		# TODO: figure out how to reset rotation without breaking everything

		# Disable the flag so we don't keep resetting
		should_reset = false

func _ready() -> void:
	EventBus.connect("play", _on_play)
	EventBus.connect("pause", _on_pause)
	EventBus.connect("reset", _on_reset)

	# set initial play/pause state
	if play_pause_button.is_playing:
		_on_play()
	else:
		_on_pause()

func _on_play() -> void:
	get_tree().paused = false
	collision_mask = 1 # bitmask

func _on_pause() -> void:
	get_tree().paused = true
	collision_mask = 0 # bitmask

func _on_reset() -> void:
	# Move us back to the start
	should_reset = true

func _on_body_entered(body) -> void:
	if not play_pause_button.is_playing:
		return
	# We just hit something
	if body is Obstacle:
		# We bonked an obstacle
		var isDead = body.get_bonked()
		if isDead:
			# We died
			print("You died")
			should_reset = true
	else:
		print("Hit something unknown")
