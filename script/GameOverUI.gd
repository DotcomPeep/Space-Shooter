extends Control


func add_points(points:int):
	$Panel/ScoreLabel.text = "Score: " + str(points)


func _on_Button_pressed():
	get_tree().reload_current_scene()
