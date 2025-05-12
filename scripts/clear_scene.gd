extends TextureButton

func _ready() -> void:
	EventBus.connect("clear_scene", clear_scene)

func clear_scene() -> void:
	# Get "Generated" node
	var generated = get_tree().root.get_node("Generated")
	# Check if it exists
	if generated:
		# Get all children of "Generated" node
		var children = generated.get_children()
		# Iterate through each child and remove it
		for child in children:
			# Remove the child from the scene tree
			print("Removing child: ", child.name)
			child.queue_free()
	else:
		print("No 'Generated' node found. Nothing to clear.")
