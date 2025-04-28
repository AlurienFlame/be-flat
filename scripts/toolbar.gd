extends Control

func make_instance(obj: Resource) -> void:
	# Called when the button is pressed
	print("Instantiating object")

	var instance = obj.instantiate()
	instance.position = Vector2(50, 50) # Set the position as needed
	# make node called "Generated" in scene if it doesn't exist
	
	# get top of scene tree
	var scene_tree = get_tree()
	var root = scene_tree.root
	# check if "Generated" node exists
	var generated = root.get_node("Generated")
	if not generated:
		# create node called "Generated"
		generated = Node2D.new()
		generated.name = "Generated"
		root.add_child(generated)
	# add instance to "Generated" node
	generated.add_child(instance)

	

func _on_rectangle_pressed() -> void:
	print("Instantiating rectangle")

	var rectangle_scene = load("res://scenes/obstacles/rectangleObstacle.tscn")
	make_instance(rectangle_scene)

func _on_circle_pressed() -> void:
	print("Instantiating circle")

	var circle_scene = load("res://scenes/obstacles/circleObstacle.tscn")
	make_instance(circle_scene)
	

func _on_triangle_pressed() -> void:
	print("Instantiating triangle")
	var triangle_scene = load("res://scenes/obstacles/triangleObstacle.tscn")
	make_instance(triangle_scene)


func _on_rhombus_pressed() -> void:
	print("Instantiating rhombus")

	var rhombus_scene = load("res://scenes/obstacles/rhombusObstacle.tscn")
	make_instance(rhombus_scene)

func _on_objective_pressed() -> void:
	print("Instantiating objective")

	var objective_scene = load("res://scenes/objective.tscn")
	make_instance(objective_scene)
