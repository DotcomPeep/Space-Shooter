extends Area2D


var speed = 800
var started = false


func _ready():
	pass


func _process(delta):
	global_position.x = global_position.x + (speed * delta)


func _on_Timer_timeout():
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Rocket_area_entered(area):
	area.die()
	queue_free()
