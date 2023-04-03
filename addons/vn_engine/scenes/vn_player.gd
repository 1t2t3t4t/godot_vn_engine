extends Control

class_name VNPlayer

signal flow_completed

@onready var speaker_label: Label = $VBoxContainer/SpeakerLabel
@onready var dialog_text: RichTextLabel = $VBoxContainer/DialogBox/MarginContainer/DialogText
@onready var type_writer_text_updater: TypeWriterTextUpdater = $TypeWriterTextUpdater as TypeWriterTextUpdater

var config: VNConfig

var _current_flow: VNFlow
var _ready_next_flow := false

func _ready() -> void:
	type_writer_text_updater.char_delay = config.char_delay


func show_flow(flow: VNFlow) -> void:
	_current_flow = flow
	_ready_next_flow = false
	if flow is VNDialog:
		var dialog := flow as VNDialog
		speaker_label.text = dialog.actor
		type_writer_text_updater.start(dialog.dialog)
	else:
		assert(false, "Unhandled flow %s" % flow.id)


# Signal from TypeWriterTextUpdater
func _on_text_update(new_text) -> void:
	dialog_text.text = new_text


func _on_completed() -> void:
	_ready_next_flow = true


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
	if not _ready_next_flow:
		type_writer_text_updater.stop()
	else:
		_complete_flow()


func _complete_flow() -> void:
	flow_completed.emit()
