extends RichTextLabel

@onready var tracker := $CollectedTracker


var total_parts := 0
var collected_parts := 0

func _ready():
    count_collectibles()
    EventBus.connect("reset", func(): _on_reset())


func count_collectibles():
    var collectibles = get_tree().get_nodes_in_group("collectibles")
    total_parts = collectibles.size()
    collected_parts = 0
    for collectible in collectibles:
        if not collectible.is_connected("collected", Callable(self, "_on_collect")):
            collectible.connect("collected", Callable(self, "_on_collect"))
    update_text()
    
func _on_collect():
    collected_parts += 1
    update_text()

func update_text():
    text = "Collected: %d / %d" % [collected_parts, total_parts]
    
func _on_reset():
    await get_tree().process_frame
    count_collectibles()
    
