extends Node

class_name TypeWriterTextUpdater

signal text_update(new_text: String)
signal completed

@onready var _dialog_display_timer: Timer = $DialogDisplayTimer

var _target_text: String
var _char_index: int

var _current_text: String:
	set(new_text):
		_current_text = new_text
		text_update.emit(new_text)
		if _current_text == _target_text:
			completed.emit()

## Character delay when displaying in millisec
var char_delay: int = 25

func _ready() -> void:
	# Ensure timer
	_dialog_display_timer.one_shot = true
	_dialog_display_timer.autostart = false
	_dialog_display_timer.wait_time = float(char_delay) / 1000
	_dialog_display_timer.timeout.connect(_on_dialog_display_timer_timeout)

func _on_dialog_display_timer_timeout() -> void:
	if _current_text != _target_text:
		var next_char := _target_text.substr(_char_index, 1)
		_current_text += next_char
		_char_index += 1
		_dialog_display_timer.start()

func start(text: String) -> void:
	_target_text = text
	_current_text = ""
	_dialog_display_timer.start()

## Stop timer and set text to be target text
func stop() -> void:
	if not _dialog_display_timer.is_stopped():
		_dialog_display_timer.stop()
	_current_text = _target_text
