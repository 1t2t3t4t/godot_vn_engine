extends Node

class_name VNHandler

signal text_updated(new_text: String)
signal handler_completed

func config(vn_config: VNConfig) ->void:
	pass

func handle_process_next() -> void:
	pass
