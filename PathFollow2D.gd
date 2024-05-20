extends PathFollow2D

@onready var area_2d = $Area2D
@export var lap_time = 10.0 # 10 second lap time
var time_spent = 0.0 # 10 second lap time
var is_enemy = false
var blue_car = preload("res://PNG/Cars/car_blue_small_3.png")
var red_car = preload("res://PNG/Cars/car_red_small_3.png")

@onready var sprite_2d = $Area2D/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.add_to_group("hero")
	sprite_2d.texture = red_car
	if (!is_enemy):
		time_spent = lap_time / 2.5

func make_enemy():
	sprite_2d.texture = blue_car
	sprite_2d.rotation_degrees = 270
	# area_2d.add_to_group("enemy")
	area_2d.remove_from_group("hero")
	is_enemy = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_spent += delta
	time_spent = wrapf(time_spent, 0, lap_time)
	set_progress_ratio((time_spent / lap_time) * (-1 if is_enemy else 1))
