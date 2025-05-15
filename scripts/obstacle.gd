class_name Obstacle extends StaticBody2D

# export variables
@export var isDeadly = false
@export var isMoving = false
@export var speed = 100

enum Direction {
    NONE,
    LEFT,
    RIGHT,
    UP,
    DOWN
}

@export var direction: Direction

var move_vector: Vector2
var original_position: Vector2


func _ready():
    EventBus.connect("reset", reset_obstacle)
    original_position = position
    # set speed if isMoving
    if isMoving:
        # set direction
        match direction:
            Direction.LEFT:
                move_vector = Vector2.LEFT
            Direction.RIGHT:
                move_vector = Vector2.RIGHT
            Direction.UP:
                move_vector = Vector2.UP
            Direction.DOWN:
                move_vector = Vector2.DOWN
            _:
                move_vector = Vector2.ZERO

func _process(delta: float) -> void:
    if isMoving:
        # move the object
        position += move_vector * speed * delta
        # check if it hits the border
        if position.x < 0 or position.x > get_viewport_rect().size.x:
            move_vector.x = -move_vector.x
        if position.y < 0 or position.y > get_viewport_rect().size.y:
            move_vector.y = -move_vector.y

func get_bonked() -> bool:
    $AudioStreamPlayer2D.play()
    if isDeadly:
        # kill player
        reset_obstacle()
        return true
    return false


# if it hits the border, reverse the direction
func _on_body_entered(_body) -> void:
    if isMoving:
        # reverse the direction
        move_vector = -move_vector

func reset_obstacle() -> void:
    # check if this node has a child Draggable
    if !get_node("Draggable"):
        position = original_position

    match direction:
        Direction.LEFT:
            move_vector = Vector2.LEFT
        Direction.RIGHT:
            move_vector = Vector2.RIGHT
        Direction.UP:
            move_vector = Vector2.UP
        Direction.DOWN:
            move_vector = Vector2.DOWN
