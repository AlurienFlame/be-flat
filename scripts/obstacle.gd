class_name Obstacle extends StaticBody2D

# export variables
@export var isDeadly = false
@export var isMoving = false
@export var speed = 100
# vector of the direction the object is moving
var move_vector = Vector2.ZERO

var original_position: Vector2


func _ready():
	original_position = position
	# set speed if isMoving
	if isMoving:
		print("Obstacle is moving")
		# set the speed to the right
		move_vector = Vector2.RIGHT

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
		position = original_position
		return true
	return false


# if it hits the border, reverse the direction
func _on_body_entered(body) -> void:
	if isMoving:
		# reverse the direction
		move_vector = -move_vector
