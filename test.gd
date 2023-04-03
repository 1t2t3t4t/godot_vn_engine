extends Node2D

@onready var vn_controller := $VNController as VNController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vn_controller.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
