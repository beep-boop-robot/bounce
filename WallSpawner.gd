extends Node2D

signal created_wall(wall)

export var poll_interval = 0.1
export var time_between_spawn = 1.0

var Wall = preload("res://Wall.tscn")

var poll_timer = 0.0
var spawn_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    poll_timer += delta
    spawn_timer += delta
    if poll_timer > poll_interval:
        poll_timer = 0
        if randf() <= (spawn_timer / time_between_spawn):
            spawn_timer = 0
            var wall = Wall.instance()
            emit_signal("created_wall", wall)
