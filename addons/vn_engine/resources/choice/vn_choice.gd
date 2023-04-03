extends Resource

class_name VNChoice

@export var id: StringName
@export var text: String
@export var effect: Resource
## Specify next flow to go to. If not set (value is -1) will default go to next flow
@export var jump_to: int = -1
