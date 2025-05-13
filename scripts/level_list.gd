extends HFlowContainer

@onready var puzzle_button: PackedScene = preload("res://scenes/UI/puzzle_button.tscn")

func _ready() -> void:
    var levels = DirAccess.get_files_at("res://scenes/levels")
    var unlocked_first_level = false
    for filename in levels:
        var button: PuzzleButton = puzzle_button.instantiate()
        add_child(button)

        # Set button text and enabledness to defaults (only first unlocked)
        if unlocked_first_level:
            button.init(filename, false)
        else:
            button.init(filename, true)
            unlocked_first_level = true

        # Override with saved progress if applicable
        load_progress()

func unlock_level(level: int) -> void:
    var button: PuzzleButton = get_child(level - 1) # convert to 0-based index
    button.unlock()
    save_progress()

func save_progress():
    # Collect information about which levels are unlocked
    var which_levels_are_unlocked = {}
    for i in range(get_child_count()):
        var button: PuzzleButton = get_child(i)
        which_levels_are_unlocked[i] = button.is_unlocked()

    # Save the information to the user storage
    var save_file = FileAccess.open("user://progress.save", FileAccess.WRITE)
    save_file.store_var(which_levels_are_unlocked)
    save_file.close()

func load_progress():
    if not FileAccess.file_exists("user://progress.save"):
        return

    # Load progress from file
    var save_file = FileAccess.open("user://progress.save", FileAccess.READ)
    var which_levels_are_unlocked = save_file.get_var()

    # Apply data to buttons
    for i in range(get_child_count()):
        var button: PuzzleButton = get_child(i)
        if which_levels_are_unlocked[i]:
            button.unlock()
        else:
            button.disabled = true
    save_file.close()
