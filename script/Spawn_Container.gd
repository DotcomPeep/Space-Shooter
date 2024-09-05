extends Node2D


signal spawn_enemy(enemy)


onready var spawn_positions: Node2D = $Spawn_Position
var enemy_scene: PackedScene = preload("res://scene/Enemy.tscn")


func _on_Timer_timeout():
	var spawn_position_array = spawn_positions.get_children()

	var random_index = randi() % spawn_position_array.size()
	var random_position: Node2D = spawn_position_array[random_index]
	
	var enemy_instance = enemy_scene.instance()
	
	enemy_instance.position = random_position.position
	
	add_child(enemy_instance)

	emit_signal("spawn_enemy", enemy_instance)
