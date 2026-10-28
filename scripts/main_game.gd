extends Node

@export var mob_scene: PackedScene
var score


func _ready():
	new_game()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	print("Game over. Puntos: " + str(score))


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout():
	# creamos una instancia nueva de la escena mob
	var mob = mob_scene.instantiate()

	# elegimos un punto aleatorio del path
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# ponemos el enemigo en ese punto
	mob.position = mob_spawn_location.position

	# direccion perpendicular al path (hacia dentro)
	var direction = mob_spawn_location.rotation + PI / 2

	# un poco de aleatoriedad en la direccion
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# velocidad del enemigo
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# lo añadimos a la escena main
	add_child(mob)
