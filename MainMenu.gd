extends Control


signal start()

# Called when the node enters the scene tree for the first time.
func _ready():
    var view_size = get_viewport().size
    rect_size = Vector2(view_size.x, view_size.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_PlayButton_pressed():
    emit_signal("start")
