@tool

extends Node

class_name VNController

@export_category("Objects")
@export var ui_control: Control

@export_category("State")
@export var initial_scene: VNScene

var current_scene: VNScene:
	set(new_scene):
		print("Transition scene %s to %s" % [current_scene.id, new_scene.id])
		current_scene = new_scene


