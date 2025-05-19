extends Node

enum AudioChannels {
	MASTER,
	MUSIC,
	SFX
}

func _ready() -> void:
	self.value = 100

func set_master_volume(value_changed:bool) -> void:
	if value_changed:
		# var value = AudioServer.get_bus_volume_db(AudioChannels.MASTER)
		var newValue = self.value
		print("Slider changed to: %f" % newValue)
		# Convert to decibel value from -72 to 0
		var newDecibel = -72 - ((newValue / 100) * -72)
		print ("New decibel value: %f" % newDecibel)
		AudioServer.set_bus_volume_db(AudioChannels.MASTER, newDecibel)
		# Play a bonk sound
		$AudioStreamPlayer2D.play()
