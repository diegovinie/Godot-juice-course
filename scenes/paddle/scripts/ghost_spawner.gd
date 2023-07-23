extends Node2D

@export var ghost_scene: PackedScene = preload("res://scenes/paddle/ghost.tscn")
@export var sprite: Sprite2D
@export var color: Color

func start_spawn() -> void:
	$Timer.start()
	
func stop_spawn() -> void:
	$Timer.stop()

func _on_timer_timeout():
	var instance: Sprite2D = ghost_scene.instantiate()
	get_tree().get_current_scene().add_child(instance)
	instance.global_position = sprite.global_position
	instance.rotation = sprite.rotation
	instance.texture = sprite.texture
	instance.self_modulate = color
	instance.scale = sprite.scale
	instance.z_index = 0
	
