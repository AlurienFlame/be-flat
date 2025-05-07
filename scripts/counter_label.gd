extends RichTextLabel

@onready var tracker := $CollectedTracker


var total_parts := 0

func _ready():
	print("readylabel")
	if tracker:
		print("foundtracker")
		total_parts = get_tree().get_nodes_in_group("collectibles").size()
		var collectibles = get_tree().get_nodes_in_group("collectibles")
		for collectible in collectibles:
			print("Connecting collectible:", collectible.name)
			collectible.connect("collected", $CollectedTracker.increment)
		
		print("label Found collectibles:", collectibles.size())
		tracker.connect("parts_updated", _on_parts_updated)
		
		text = "Collected: 0 / %d" % total_parts

func _on_parts_updated(collected: int):
	text = "Collected: %d / %d" % [collected, total_parts]
	if collected == total_parts:
		#probably edit to add a different event from win
		EventBus.emit_signal("win")
	
