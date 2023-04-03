extends Node

class_name VNHandler

signal text_updated(new_text: String)
signal handler_completed

signal choices_updated(choices: Array[String])
signal choice_selected

var current_config: VNConfig

func _config(vn_config: VNConfig) ->void:
	current_config = vn_config


func _handle_process_next() -> void:
	pass
