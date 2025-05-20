class_name Character extends RigidBody2D

@onready var play_pause_button: TextureButton = $"/root/SceneManager/UI/MenuBar/PlayPauseButton"
@onready var sprite = $AnimatedSprite2D
@onready var start_position: Vector2 = position


# We use this flag to track if, on the next iteration of the physics engine,
# we should move the character back to the start position and reset the flag
var should_reset: bool = false
var should_bounce: bool = false
var player_collected: int = 0

var isDead: bool = false

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
    sprite.modulate = Color(1, 1, 1)
    sprite.play("bebe")
    get_tree().paused = false
    collision_mask = 1 # bitmask

func _on_pause() -> void:
    if position != start_position:
        sprite.modulate = Color(0.5, 0.5, 0.5)
    get_tree().paused = true
    
    collision_mask = 0 # bitmask

func _on_reset() -> void:
    # Move us back to the start
    should_reset = true
    position = start_position # This will only work for one frame before the physics engine takes over
    rotation = 0
    
    # Reset bounciness
    linear_velocity = Vector2.ZERO
    gravity_scale = 1
    linear_damp = 0.0

func on_collect() -> void:
    player_collected += 1
    sprite.play("collect")
    await get_tree().create_timer(0.5).timeout
    sprite.play("bebe")
    print("Collected suns", player_collected)

func _on_body_entered(body) -> void:
    if not play_pause_button.is_playing:
        return
    # We just hit something

    if body is not Obstacle:
        print("Hit something unknown")
        return
    
    # On hit bouncy
    if body.isBouncy:
        # Bounce off
        linear_velocity += position.direction_to(body.position) * -1 * body.bounciness

    # On bounce
    isDead = body.get_bonked()
    sprite.play("bounce")
    await get_tree().create_timer(0.2).timeout
    sprite.play("bebe")

    # On hit lethal
    if isDead:
        $AudioStreamPlayer2D.play()

        # Tone down bounciness
        linear_damp = 1
        linear_velocity = linear_velocity * 0.5
        gravity_scale = 3.0
    
        sprite.play("dead")
        await get_tree().create_timer(0.5).timeout
        sprite.play("bebe")
        # We died
        print("You died")
        EventBus.emit_signal("lose")
        should_reset = true
