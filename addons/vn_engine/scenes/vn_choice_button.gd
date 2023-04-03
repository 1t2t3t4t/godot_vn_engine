extends Button

class_name VNChoiceButton

var metadata: Metadata:
	set(new_metadata):
		metadata = new_metadata
		text = new_metadata.choice.text
		name = metadata.choice.id

class Metadata:
	var choice: VNChoice

	func _init(new_choice: VNChoice) -> void:
		choice = new_choice
