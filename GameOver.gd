extends Control

signal retry()

export var score = 0
export var time_to_display_in = 2

var score_displayed = 0
var finished = false
var t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    $CenterContainer/VBoxContainer/CenterContainer/RetryButton.grab_focus()
    var view_size = get_viewport().size
    rect_size = Vector2(view_size.x, view_size.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if not finished:
        t += delta
        score_displayed = lerp(0, score, t / time_to_display_in)
        if score_displayed > score:
            score_displayed = score
            finished = true
        $CenterContainer/VBoxContainer/HBoxContainer/ScoreLabel.text = "%d" % score_displayed   


func _on_RetryButton_pressed():
    emit_signal("retry")
