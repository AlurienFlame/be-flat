extends RichTextLabel

@onready var tracker := $CollectedTracker


var total_parts := 0

func _ready():
    if not tracker:
        return

    var collectibles = get_tree().get_nodes_in_group("collectibles")
    for collectible in collectibles:
        collectible.connect("collected", $CollectedTracker.increment)

    tracker.connect("parts_updated", _on_parts_updated)

    total_parts = collectibles.size()
    text = "Collected: 0 / %d" % total_parts

func _on_parts_updated(collected: int):
    if (total_parts == 0):
        return
    text = "Collected: %d / %d" % [collected, total_parts]
    if collected == total_parts:
        #probably edit to add a different event from win
        EventBus.emit_signal("win")
