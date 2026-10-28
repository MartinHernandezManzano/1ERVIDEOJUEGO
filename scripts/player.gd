extends Area2D

# señal que avisa a main cuando un enemigo nos toca
signal hit

@export var speed = 400 # velocidad del gatete (pixeles/seg)
var screen_size # tamaño de la ventana


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2.ZERO # vector de movimiento
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	# que no se salga de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size)

	# mira hacia donde anda
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0


func _on_body_entered(_body):
	hide() # el gatete desaparece al recibir el golpe
	hit.emit()
	# diferido porque no se pueden tocar fisicas dentro de un callback de fisicas
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
