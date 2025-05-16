extends Node2D

@onready var character = $Character  
@onready var sprite = $Character/AnimatedSprite2D
@onready var screen_size = get_viewport_rect().size
var has_lost = false

# LEVEL METADATA -- To be edited in the level editor
@export var max_objs = -1
@export var allowed_objs = ["rectangle", "circle", "triangle", "rhombus", "objective"]
@export var win_conditions = []

func _ready():
    EventBus.connect("reset", _on_reset)


    # print("Loading scene with max_objs: ", max_objs, " and allowed_objs: ", allowed_objs)
    EventBus.emit_signal("load_scene", max_objs, allowed_objs)
    
  

func _process(delta):
    if has_lost:
        return
    
    if is_character_out_of_bounds():
        has_lost = true
        EventBus.emit_signal("lose")

func is_character_out_of_bounds() -> bool:
    return character.position.x < 0 or character.position.x > screen_size.x or \
           character.position.y < 0 or character.position.y > screen_size.y

func _on_reset():
    has_lost = false
