extends KinematicBody2D


signal took_damage


var speed : int = 400
var velocity : Vector2 = Vector2() # Na versão 3.5.3 velocity deve ser declarado
var rocket_scene :PackedScene = preload("res://scene/Rocket.tscn")


var can_shoot : bool = true
var shoot_cooldown : float = 0.4  # Meio segundo entre os disparos
var shoot_timer : float = 0.0
var game_started : bool = false


onready var rocket_container = $Rocket_Container


func _ready():
	# var screen_size = get_viewport_rect().size --verificar tamanho da tela
	# print(screen_size)
	game_started = false


func _physics_process(delta):
	velocity = Vector2()
	if Input.is_key_pressed(KEY_W):
		velocity.y -= speed
	elif Input.is_key_pressed(KEY_S):
		velocity.y += speed
	
	if Input.is_key_pressed(KEY_A):
		velocity.x -= speed
	elif Input.is_key_pressed(KEY_D):
		velocity.x += speed
	
	move_and_slide(velocity)
		
	var screen_size = get_viewport_rect().size
	var minVectorPosition = Vector2(0, 90)
	# Na versão 3.5.3 temos que configurar x e y manualmente no clamp
	var clamped_position = global_position
	clamped_position.x = clamp(clamped_position.x, minVectorPosition.x, screen_size.x)
	clamped_position.y = clamp(clamped_position.y, minVectorPosition.y, screen_size.y)
	
	global_position = clamped_position
	
	if not game_started:
		if Input.is_key_pressed(KEY_SPACE):
			game_started = true  # Agora os tiros podem ser disparados pelo jogador
		
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		shoot()
		can_shoot = false
		shoot_timer = shoot_cooldown	

	if not can_shoot:
		shoot_timer -= delta
		if shoot_timer <= 0:
			can_shoot = true
	
	
func shoot():
	if rocket_container:
		var rocket_instance = rocket_scene.instance()
		rocket_instance.global_position = Vector2(global_position.x + 60, global_position.y)
		rocket_container.add_child(rocket_instance)
		# Você pode ajustar a posição inicial do míssil aqui, se necessário
		rocket_instance.global_position = global_position
		$LaserSound.play()
		
		
func take_damage():
	emit_signal("took_damage")


func die():
	queue_free()
