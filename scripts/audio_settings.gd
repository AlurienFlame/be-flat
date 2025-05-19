extends Node



enum AudioChannels {
	MASTER,
	BGM,
	SFX
}

func _ready() -> void:
	self.value = 100
	# connect("reset_audio", reset_audio_settings())

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

func set_bgm_volume(value_changed:bool) -> void:
	if value_changed:
		var newValue = self.value
		print("Slider changed to: %f" % newValue)
		# Convert to decibel value from -72 to 0
		var newDecibel = -72 - ((newValue / 100) * -72)
		print ("New decibel value: %f" % newDecibel)
		AudioServer.set_bus_volume_db(AudioChannels.BGM, newDecibel)
		# Play a bonk sound
		$AudioStreamPlayer2D.play()

func set_sfx_volume(value_changed:bool) -> void:
	if value_changed:
		var newValue = self.value
		print("Slider changed to: %f" % newValue)
		# Convert to decibel value from -72 to 0
		var newDecibel = -72 - ((newValue / 100) * -72)
		print ("New decibel value: %f" % newDecibel)
		AudioServer.set_bus_volume_db(AudioChannels.SFX, newDecibel)
		# Play a bonk sound
		$AudioStreamPlayer2D.play()

func reset_audio_settings() -> void:
	# Reset all audio settings to default
	AudioServer.set_bus_volume_db(AudioChannels.MASTER, 0)
	AudioServer.set_bus_volume_db(AudioChannels.BGM, 0)
	AudioServer.set_bus_volume_db(AudioChannels.SFX, 0)
	self.value = 100
	print("Audio settings reset to default")
