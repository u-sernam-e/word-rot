extends Node

var voices: Array[Dictionary] = DisplayServer.tts_get_voices()
var voice_id: String

signal finished_playing_tts

const SENTENCE_ID := 100

func _ready() -> void:
	DisplayServer.tts_set_utterance_callback(DisplayServer.TTS_UTTERANCE_ENDED, _on_tts_ended)
	DisplayServer.tts_set_utterance_callback(DisplayServer.TTS_UTTERANCE_CANCELED, _on_tts_ended)
	if voices.is_empty():
		push_warning("No TTS voices available on this platform")
		return
	voice_id = voices[0]["id"]

func _speak(text: String, id: int = 0) -> void:
	if voices.is_empty():
		return
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(text, voice_id, 90, 1.0, 1.0, id, true)

func _on_tts_ended(utterance_id: int) -> void:
	if utterance_id == SENTENCE_ID:
		finished_playing_tts.emit()
