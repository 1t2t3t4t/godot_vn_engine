@tool

extends Node

class_name VNController

@export_category("Objects")
@export var vn_player_scn: PackedScene
@export var config: VNConfig
@onready var vn_player: VNPlayer = vn_player_scn.instantiate() as VNPlayer

@export_category("State")
@export var initial_scene: VNScene

var current_scene: VNScene:
	set(new_scene):
		print("Transition scene to %s" % new_scene.id)
		current_scene = new_scene

func _ready() -> void:
	vn_player.config(config)
	add_child(vn_player)
	current_scene = initial_scene
	var scn := current_scene.flows[0] as VNDialog
	vn_player.show_dialog("Test speaker", scn.dialog)
