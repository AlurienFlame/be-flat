extends Control

@onready var trashcan = $"/root/SceneManager/UI/ToolBar/trashcan"
@onready var toolbar = $"/root/SceneManager/UI/ToolBar"

var dragging = false  # Are we currently dragging?
var cur_object = null  # The object currently being dragged
static var DRAGGABLE_LAYER = 2  # Collision layer for draggable objects
static var MAX_DRAG_AT_ONCE = 1  # Number of objects that can be dragged at once

func _on_gui_input(event:InputEvent):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                start_drag(event.position)
            elif dragging:
                end_drag(event.position)

    if event is InputEventMouseMotion and dragging:
        do_drag(event.position)
        
func get_item_under_mouse(pos: Vector2):
    var query = PhysicsPointQueryParameters2D.new()
    query.position = pos
    query.collide_with_areas = true # make sure we can get objectives as well as obstacles
    query.collision_mask = DRAGGABLE_LAYER
    var items = get_world_2d().direct_space_state.intersect_point(query, MAX_DRAG_AT_ONCE)
    if items.size():
        return items[0].collider

func start_drag(pos: Vector2):
    cur_object = get_item_under_mouse(pos)
    if not cur_object:
        return
    dragging = true
    trashcan.visible = true

func do_drag(pos: Vector2):
    # move the object we're dragging on top of the mouse
    cur_object.global_position = pos

func end_drag(_pos: Vector2):
    # trash stuff
    if trashcan.can_delete:
        trashcan.can_delete = false
        cur_object.queue_free()
        toolbar.remove_instance()
    trashcan.visible = false

    # let go of the object we were dragging
    cur_object = null
    dragging = false
