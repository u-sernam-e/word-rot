extends Node

var voices: Array[Dictionary] = DisplayServer.tts_get_voices()
var voice_id: String

func _ready() -> void:
	if voices.is_empty():
		push_warning("No TTS voices available on this platform")
		return
	voice_id = voices[0]["id"]

func _speak(text: String) -> void:
	DisplayServer.tts_speak(text, voice_id)
