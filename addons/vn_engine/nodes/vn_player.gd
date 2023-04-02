extends Control

class_name VNPlayer

@onready var speaker_label: Label = $VBoxContainer/SpeakerLabel
@onready var dialog_text: RichTextLabel = $VBoxContainer/DialogBox/MarginContainer/DialogText
@onready var type_writer_text_updater: TypeWriterTextUpdater = $TypeWriterTextUpdater as TypeWriterTextUpdater

var config: VNConfig

func _ready() -> void:
	type_writer_text_updater.char_delay = config.char_delay

func show_dialog(speaker: String, text: String) -> void:
	speaker_label.text = speaker
	type_writer_text_updater.start(text)

# Signal from TypeWriterTextUpdater
func _on_text_update(new_text) -> void:
	dialog_text.text = new_text

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event := event as InputEventKey
		if key_event.keycode == KEY_SPACE:
			_handle_process_next()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			_handle_process_next()

func _handle_process_next() -> void:
	type_writer_text_updater.stop()
