extends Node

class_name VNHandler

signal text_updated(new_text: String)
signal handler_completed

signal choices_updated(choices: Array[VNChoice])
signal choice_selected

var current_config: VNConfig

func config(vn_config: VNConfig) -> void:
	current_config = vn_config


func _handle_process_next() -> void:
	pass
