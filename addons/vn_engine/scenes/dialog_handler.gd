extends VNHandler

class_name DialogHandler

@onready var type_writer_text_updater := $TypeWriterTextUpdater as TypeWriterTextUpdater

var _ready_next_flow := false

func _config(vn_config: VNConfig) ->void:
	type_writer_text_updater.char_delay = vn_config.char_delay


func show_flow(dialog: VNDialog) -> void:
	_ready_next_flow = false
	type_writer_text_updater.start(dialog.dialog)


# Signal from TypeWriterTextUpdater
func _on_text_update(new_text) -> void:
	text_updated.emit(new_text)


func _on_completed() -> void:
	_ready_next_flow = true


func handle_process_next() -> void:
	if not _ready_next_flow:
		type_writer_text_updater.stop()
	else:
		handler_completed.emit()
