extends Node2D

var car = preload("res://car.tscn")
@onready var timer = $Timer
@onready var button = $Control/HBoxContainer/VBoxContainer/Button

var game_on = false

var cars = []
func _on_button_button_up():
	# Hero Car
	print("play")
	button.disabled = true
	game_on = true
	var hero_car: Car = car.instantiate()
	hero_car.collision_s.connect(collision)
	
	add_child(hero_car)
	cars.push_back(hero_car)

func generate_enemy_car():
	var enemy_car: Car = car.instantiate()
	
	enemy_car.make_enemy();
	enemy_car.update_time(randi_range(3, 8))
	add_child(enemy_car)
	cars.push_back(enemy_car)

func _delete(_car: Car):
	print(_car)
	_car.queue_free()
	return true

func collision():
	game_on = false
	print(cars)
	button.disabled = false
	get_tree().paused = true
	cars.all(_delete)
	

func _on_lap_box_area_exited(area: Area2D):
	if (area.get_groups().find("hero") > -1):
		if (timer.is_stopped()):
			timer.wait_time = randi_range(1, 4)
			timer.start()

# generate new car
func _on_timer_timeout():
	print(timer.wait_time)
	if (game_on):
		generate_enemy_car()
