extends Sprite2D

# señales propias (apartado custom signals del tutorial)
signal puntos_cambiados(old_value, new_value)
signal objetivo_completado

@export var speed: float = 240.0

var puntos: int = 0


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		print("MIAU")
		sumar_punto()


func sumar_punto() -> void:
	var puntos_antes = puntos
	puntos += 1
	print("Puntos: " + str(puntos))
	puntos_cambiados.emit(puntos_antes, puntos)
	if puntos >= 5:
		print("Objetivo finalizado")
		objetivo_completado.emit()
