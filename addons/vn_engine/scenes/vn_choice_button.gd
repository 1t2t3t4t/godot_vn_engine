extends Button

class_name VNChoiceButton

var metadata: Metadata

class Metadata:
	var choice: VNChoice

	func _init(new_choice: VNChoice) -> void:
		choice = new_choice
