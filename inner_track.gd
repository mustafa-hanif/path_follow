class_name Track extends Path2D
@onready var path_follow_2d = $PathFollow2D
@export var track_name: String
@onready var area_2d = $PathFollow2D/Area2D

var is_enemy = false
var is_enabled = true
signal car_collide

func make_enemy():
	is_enemy = true
	path_follow_2d.make_enemy()

func disable():
	is_enabled = false
	visible = false
	if (is_enemy):
		area_2d.remove_from_group("enemy")
	
func enable():
	visible = true
	is_enabled = true
	if (is_enemy):
		area_2d.add_to_group("enemy")
	
func _on_area_2d_area_exited(area: Area2D):
	if (!is_enemy):
		print("collide", area.get_groups(), is_enabled, track_name)
	if (!is_enemy && (area.get_groups().find("enemy") > -1)):
		if (is_enabled):
			car_collide.emit()
			
