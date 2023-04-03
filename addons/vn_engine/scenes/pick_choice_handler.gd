extends DialogHandler

class_name PickChoiceHandler

var _current_flow: VNPickChoice

func handle(flow: VNDialog) -> void:
	super(flow)
	_current_flow = flow as VNPickChoice
	choices_updated.emit(_current_flow.choices)

