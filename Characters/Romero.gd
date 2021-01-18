extends Area2D

const HEART_SPEED = 16
const HEART_DECAY_IN_MIN = 0.5
const HEART_DECAY_IN_MAX = 1.5
const HEART_DECAY_OUT = 1.5
const HEART_SPAWN_FREQUENCY = 20
const HEART_TEXTURE = preload("res://assets/Props/heart sticker.png")

var hearts = []
var spawn_counter = 0
var spawn_x_min
var spawn_x_max
var spawn_y

func _ready():
	randomize()
	spawn_x_min = min_x($HeartSpawn.polygon)
	spawn_x_max = max_x($HeartSpawn.polygon)
	spawn_y = min_y($HeartSpawn.polygon)

func _process(delta):
	spawn_counter += 1
	if spawn_counter == HEART_SPAWN_FREQUENCY:
		spawn_counter = 0
		spawn_heart()
	var new_hearts = []
	for heart in hearts:
		update_heart(heart, delta)
		if heart.state == "_done":
			remove_child(heart.sprite)
		else:
			new_hearts.push_back(heart)
	hearts = new_hearts

func update_heart(heart, delta):
	heart.sprite.position.y -= HEART_SPEED * delta
	match heart.state:
		"init": 
			heart.state = "decay_in"
			heart.sprite.modulate.a = 0.01
			add_child(heart.sprite)		
		"decay_in":
			if heart.sprite.modulate.a >= 1:
				heart.state = "decay_out"
			else:
				heart.sprite.modulate.a += sample_range(HEART_DECAY_IN_MIN, HEART_DECAY_IN_MAX) * delta	
		"decay_out":
			heart.sprite.modulate.a -= HEART_DECAY_OUT * delta	
			if heart.sprite.modulate.a <= 0:
				heart.state = "_done"
	
func spawn_heart():	
	var spawn_x = sample_range(spawn_x_min, spawn_x_max)
	var spawn_point = Vector2(spawn_x, spawn_y)
	var sprite = Sprite.new()
	sprite.texture = HEART_TEXTURE
	sprite.rotation_degrees = 43.4
	sprite.position = spawn_point
	sprite.z_index = 1
	var scale = sample_range(0.5, 1.0)
	sprite.scale = Vector2(scale, scale)
	hearts.push_back({"sprite": sprite, "state": "init"})
	
func sample_range(minv, maxv):
	return minv + randf() * (maxv - minv)
	
func min_y(polygon):
	var all_y = []
	for point in polygon:
		all_y.push_back(point.y)
	return all_y.min()
	
func max_x(polygon):
	var all_x = []
	for point in polygon:
		all_x.push_back(point.x)
	return all_x.max()
	
func min_x(polygon):
	var all_x = []
	for point in polygon:
		all_x.push_back(point.x)
	return all_x.min()
