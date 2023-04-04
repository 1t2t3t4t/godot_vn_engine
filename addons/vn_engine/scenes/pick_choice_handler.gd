extends VNHandler

class_name PickChoiceHandler

var _current_flow: VNPickChoice

func handle(flow: VNPickChoice) -> void:
	_current_flow = flow
	choices_updated.emit(_current_flow.choices)


func button_added(button: VNChoiceButton) -> void:
	button.pressed.connect(_on_choice_selected.bind(button))


func _on_choice_selected(button: VNChoiceButton) -> void:
	print("Selected %s" % button.metadata.choice.text)
