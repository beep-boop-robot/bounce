extends Node2D

export var speed = 10.0

var ignore_offscreen = true

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _process(delta):
    position += Vector2(0, speed * delta)


func _on_VisibilityNotifier2D_screen_entered():
    ignore_offscreen = false

func _on_VisibilityNotifier2D_screen_exited():
    if not ignore_offscreen:
        print_debug("destroying ", self)
        queue_free()
