extends Node2D

@onready var vn_controller := $VNController as VNController

func _ready() -> void:
	vn_controller.start()
