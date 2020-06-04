extends Node2D

signal created_boxes(boxes)

var Box = preload("res://Box.tscn")

export var time_between_spawn = 2.0
export var invalid_box_chance = 0.1
var spawn_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    spawn_timer += delta
    if spawn_timer > time_between_spawn:
        spawn_timer = 0
        var num_to_create = randi() % 3 + 1
        var hit_dir = Vector2(rand_range(-1, 1), 0)
        var is_invalid = randf() < invalid_box_chance
        var boxes = []
        var x_offset = (-num_to_create / 2) * 64 # todo use real size
        for i in range(num_to_create):
            var box = Box.instance()
            box.invalid = is_invalid
            box.hit_direction = hit_dir
            box.position.x = x_offset
            boxes.append(box)
            x_offset += 64 # todo replace with actual size
        emit_signal("created_boxes", boxes)
