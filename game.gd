extends Node2D

var car = preload("res://car.tscn")
@onready var timer = $Timer
@onready var button = $Control/HBoxContainer/VBoxContainer/Button
@onready var score = $Control/HBoxContainer/VBoxContainer/Score

var game_on = false

var cars = []
var _score = 0

func _on_button_button_up():
	# Hero Car
	_score = 0
	set_score(_score)
	print("play")
	button.disabled = true
	game_on = true
	var hero_car: Car = car.instantiate()
	hero_car.collision_s.connect(collision)
	
	add_child(hero_car)
	cars.push_back(hero_car)
	
	generate_enemy_car()

func generate_enemy_car():
	var enemy_car: Car = car.instantiate()
	
	enemy_car.make_enemy();
	enemy_car.update_time(3)
	add_child(enemy_car)
	cars.push_back(enemy_car)

func set_score(val):
	_score = val
	score.text = str(_score)

func _delete(_car: Car):
	print(_car)
	_car.queue_free()
	remove_child(_car)
	return true

func collision():
	game_on = false
	print(cars)
	button.disabled = false
	cars.all(_delete)
	cars = []
	

func _on_lap_box_area_exited(area: Area2D):
	if (area.get_groups().find("hero") > -1):
		if (timer.is_stopped()):
			timer.wait_time = 1
			_score += 1
			set_score(_score)
			timer.start()

# generate new car
func _on_timer_timeout():
	print(timer.wait_time)
	if (game_on):
		generate_enemy_car()
