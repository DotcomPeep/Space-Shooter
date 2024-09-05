extends Control


onready var score_label = $ScoreLabel
onready var lifes_label = $LifesLabel


func _ready():
	if score_label == null:
		print("Erro: Não foi possível encontrar o nó ScoreLabel")
	if lifes_label == null:
		print("Erro: Não foi possível encontrar o nó LifesLabel")


func set_lifes(lifes:int) -> void:
	if lifes_label != null:
		lifes_label.text = "Lifes: " + str(lifes)
	else:
		print("Erro: lifes_label é nulo")


func add_points(points:int) -> void:
	if score_label != null:
		score_label.text = "Score: " + str(points)
	else:
		print("Erro: score_label é nulo")
