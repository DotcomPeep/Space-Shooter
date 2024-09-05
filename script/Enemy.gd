extends Area2D

signal give_points(points)


export var speed:int = 300
export var points:int = 10


func _process(delta) -> void:
	global_position.x = global_position.x - (speed * delta)
	
	
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Enemy_area_entered(area) -> void:
	queue_free()
	
	
func die() -> void:
	emit_signal("give_points", points)
	queue_free()


func _on_Enemy_body_entered(body) -> void:
	body.take_damage()
	die()
