extends Control

# Haven note: I do like having this as an export because we can vary per puzzle?
@export var maxObjects = -1 # No limit by default
var curObjects = 0
@onready var draggable_script = preload("res://scripts/draggable.gd")

func _ready() -> void:
    EventBus.connect("pause", _on_pause)
    EventBus.connect("play", _on_play)
    EventBus.connect("load_scene", _on_load_scene)

func _on_pause():
    $rectangle.disabled = false
    $circle.disabled = false
    $triangle.disabled = false
    $rhombus.disabled = false
    $exit.disabled = false

func _on_play():
    $rectangle.disabled = true
    $circle.disabled = true
    $triangle.disabled = true
    $rhombus.disabled = true
    $exit.disabled = true

func make_instance(obj: Resource) -> void:
    if curObjects >= maxObjects && maxObjects > 0:
        print("Max objects reached")
        return
    # Called when the button is pressed
    # print("Instantiating object")

    var instance = obj.instantiate()

    # Make the object draggable
    var drag = Node2D.new()
    drag.name = "Draggable"
    drag.set_script(draggable_script)
    instance.connect("mouse_shape_entered", drag._on_mouse_obstacle_entered)
    instance.connect("mouse_shape_exited", drag._on_mouse_obstacle_exited)
    print("Connected mouse shape entered and exited signals")
    # Make node not pausable
    instance.process_mode = PROCESS_MODE_ALWAYS
    drag.process_mode = PROCESS_MODE_WHEN_PAUSED
    
    instance.add_child(drag)

    # Spawn in the center of the viewport
    var viewport = get_viewport()
    var center = viewport.get_visible_rect().size / 2
    instance.position = center

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

    curObjects += 1

func remove_instance() -> void:
    # Called from draggable.gd when the object is deleted
    curObjects -= 1
    

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

func _on_load_scene(max_objs: int, allowed_objs: Array) -> void:
    # Called when the level is loaded
    print("Loading scene")
    print("Max objects: ", max_objs)
    print("Allowed objects: ", allowed_objs)
    maxObjects = max_objs if max_objs != null else -1
    print("Max objects: ", maxObjects)
    print("Allowed objects: ", allowed_objs)
    if allowed_objs != null:
        for obj in allowed_objs:
            match obj:
                "rectangle":
                    $rectangle.visible = true
                "circle":
                    $circle.visible = true
                "triangle":
                    $triangle.visible = true
                "rhombus":
                    $rhombus.visible = true
                "exit":
                    $exit.visible = true
                _:
                    pass
