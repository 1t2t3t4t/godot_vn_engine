extends Control

class_name VNPlayer

@export_category("Dialog Config")
## Character delay when displaying in millisec
@export_range(0, 300, 1, "or_greater", "suffix") var char_delay: int = 25

@onready var speaker_label: Label = $VBoxContainer/SpeakerLabel
@onready var dialog_text: RichTextLabel = $VBoxContainer/DialogBox/MarginContainer/DialogText

@onready var _dialog_display_timer: Timer = $DialogDisplayTimer

var _original_text: String

var _char_index: int
var _current_text: String

func _ready() -> void:
	# Ensure timer
	_dialog_display_timer.one_shot = true
	_dialog_display_timer.autostart = false
	_dialog_display_timer.wait_time = float(char_delay) / 1000

func show_dialog(speaker: String, text: String) -> void:
	speaker_label.text = speaker
	_original_text = text
	_current_text = ""

	update_dialog_box()
	_flow_dialog()

func force_show_full_dialog() -> void:
	if not _dialog_display_timer.is_stopped():
		_dialog_display_timer.stop()
	_current_text = _original_text
	update_dialog_box()

func _flow_dialog() -> void:
	_dialog_display_timer.start()

func update_dialog_box() -> void:
	dialog_text.text = _current_text

func _on_dialog_display_timer_timeout() -> void:
	if _current_text != _original_text:
		var next_char := _original_text.substr(_char_index, 1)
		_current_text += next_char
		update_dialog_box()
		_char_index += 1
		_dialog_display_timer.start()
