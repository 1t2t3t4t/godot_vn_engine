@tool

extends Node

class_name VNController

@export_category("Objects")
@export var vn_player_scn: PackedScene
@export var config: VNConfig:
	set(new_config):
		config = new_config
		update_configuration_warnings()

@export_category("State")
@export var initial_scene: VNScene

@onready var vn_player := vn_player_scn.instantiate() as VNPlayer

var current_scene: VNScene:
	set(new_scene):
		print("Transition scene to %s" % new_scene.id)
		current_scene = new_scene


func _get_configuration_warnings() -> PackedStringArray:
	var result: Array[String] = []
	if config == null:
		result.append("VNConfig is empty")
	return PackedStringArray(result)


func _ready() -> void:
	vn_player.config = config
	add_child(vn_player)


func start(new_scene: VNScene = null) -> void:
	current_scene = new_scene if not new_scene == null else initial_scene
	_start_current_flows()


func _start_current_flows() -> void:
	var flows: Array[VNFlow] = current_scene.flows
	_validate_scene(current_scene)
	var idx := 0
	while idx < len(flows):
		var flow := flows[idx]
		vn_player.show_flow(flow)
		await vn_player.flow_completed
		idx += 1


func _validate_scene(scene: VNScene) -> void:
	for i in range(len(scene.flows)):
		var flow := scene.flows[i]
		if flow.id.is_empty():
			printerr("Flow from scene %s at index %s has empty id" % [scene.id, i])
