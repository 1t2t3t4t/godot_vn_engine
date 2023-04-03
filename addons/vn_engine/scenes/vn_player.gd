extends Control

class_name VNPlayer

signal flow_completed

@onready var speaker_label: Label = $VBoxContainer/SpeakerLabel
@onready var dialog_text: RichTextLabel = $VBoxContainer/DialogBox/MarginContainer/DialogText

@onready var dialog_handler := $Handlers/DialogHandler as DialogHandler

var config: VNConfig

var _current_flow: VNFlow
var _current_actor: String

var _current_handler: VNHandler

func _ready() -> void:
	_setup_handler(dialog_handler)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event := event as InputEventKey
		if key_event.keycode == KEY_SPACE:
			_handle_process_next()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.is_pressed() && \
			mouse_event.button_index == MOUSE_BUTTON_LEFT:
			_handle_process_next()


func _setup_handler(handler: VNHandler) -> void:
	handler.config(config)
	handler.text_updated.connect(_text_updated)
	handler.handler_completed.connect(_complete_flow)


func show_flow(flow: VNFlow) -> void:
	_current_flow = flow
	if _current_actor != flow.actor and not flow.actor.is_empty():
			_current_actor = flow.actor
			speaker_label.text = _current_actor

	if flow is VNDialog:
		_current_handler = dialog_handler
		dialog_handler.show_flow(flow)
	else:
		assert(false, "Unhandled flow %s" % flow.id)


func _handle_process_next() -> void:
	_current_handler.handle_process_next()


func _complete_flow() -> void:
	flow_completed.emit()


func _text_updated(new_text: String) -> void:
	dialog_text.text = new_text
