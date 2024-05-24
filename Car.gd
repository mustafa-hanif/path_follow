class_name Car extends Node

@onready var outer_track: Track = $OuterTrack
@onready var inner_track: Track = $InnerTrack
@onready var timer = $Timer

signal collision_s

var is_enemy = false
enum TRACK { OUT, IN }
var track_visible = TRACK.IN
var time_to_switch = 0;

func update_time(val):
	time_to_switch = val

# Called when the node enters the scene tree for the first time.
func _ready():
	if (is_enemy):
		timer.wait_time = time_to_switch
		timer.start()
	
		outer_track.make_enemy()
		inner_track.make_enemy()
	else:
		outer_track.car_collide.connect(collision)
		inner_track.car_collide.connect(collision)
		
	outer_track.disable()
	inner_track.enable()
	

func _input(event):
	if (!is_enemy):
		if event.is_action_pressed("jump"):
			switch_tracks()
	
func make_enemy():
	is_enemy = true

func collision():
	print("collision")
	collision_s.emit()

func switch_tracks():
	if (track_visible == TRACK.OUT):
		track_visible = TRACK.IN
		outer_track.disable()
		inner_track.enable()
	else:
		track_visible = TRACK.OUT
		outer_track.enable()
		inner_track.disable()

func _on_timer_timeout():
	switch_tracks()
