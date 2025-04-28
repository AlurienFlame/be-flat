class_name Character extends RigidBody2D

@onready var play_pause_button: TextureButton = $"/root/Game/UI/MenuBar/PlayPauseButton"
@onready var modal_you_win: PanelContainer = $"/root/Game/UI/ModalYouWin"

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
    play_pause_button.connect("play", _on_play)
    play_pause_button.connect("pause", _on_pause)
    modal_you_win.connect("reset", _on_reset)

func _on_play() -> void:
    Engine.time_scale = 1.0

func _on_pause() -> void:
    Engine.time_scale = 0.0

func _on_reset() -> void:
    # Move us back to the start
    should_reset = true

func _on_body_entered(body) -> void:
    # We just hit something
    if body is Obstacle:
        # We bonked an obstacle
        body.get_bonked()
    else:
        print("Hit something unknown")
