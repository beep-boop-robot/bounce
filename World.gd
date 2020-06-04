extends Node2D

signal set_score(val)
signal set_multiplyer(val)
signal game_over(score)

export var max_scroll_speed = 500
export var scroll_increase_factor = 1.1
export var scroll_speed = 100

export var score_per_box = 10
export var multiplyer_per_box = 0.1

var MoveToBottom = preload("res://MoveToBottom.tscn")

var wall_position_a = Vector2(0, -100)
var wall_position_b = Vector2(600, -100)
var wall_flip = false

var score = 0
var multiplyer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
func _on_Timer_timeout():
    print_debug("increasing speed")

func _on_WallSpawner_created_wall(wall):
    print_debug("created wall")
    var move_to_bottom = MoveToBottom.instance()
    move_to_bottom.add_child(wall)
    move_to_bottom.speed = scroll_speed
    add_child(move_to_bottom)    
    
    if wall_flip:
        move_to_bottom.position = wall_position_a
    else:
        move_to_bottom.position = wall_position_b
    wall_flip = !wall_flip

func _on_Box_hit_correct():
    # todo increase score based on velocity magnitude?
    multiplyer += multiplyer_per_box
    score += score_per_box * multiplyer
    emit_signal("set_score", score)
    emit_signal("set_multiplyer", multiplyer)
    
func _on_Box_hit_incorrect():    
    multiplyer -= multiplyer_per_box
    multiplyer = max(1, multiplyer)
    score += score_per_box * multiplyer
    emit_signal("set_score", score)
    emit_signal("set_multiplyer", multiplyer)
    
func _on_Box_hit_invalid():  
    _gameover()

func _on_BoxSpawner_created_boxes(boxes):
    print_debug("created boxes")
    var move_to_bottom = MoveToBottom.instance()
    for box in boxes:
        box.connect("hit_correct", self, "_on_Box_hit_correct")
        box.connect("hit_incorrect", self, "_on_Box_hit_incorrect")
        box.connect("hit_invalid", self, "_on_Box_hit_invalid")
        move_to_bottom.add_child(box)
    move_to_bottom.speed = scroll_speed
    move_to_bottom.position.x = rand_range(100, 500)
    add_child(move_to_bottom)

func _on_Player_off_screen():
    _gameover()

func _on_ScrollSpeedTimer_timeout():
    scroll_speed = min(scroll_speed * scroll_increase_factor, max_scroll_speed)    
    print_debug("increasing scroll speed ", scroll_speed)
    for child in get_children():
        if child.get("speed"):
            child.speed = scroll_speed

    print_debug("increasing player acceleration")
    $Player.increase()

func _gameover():
    print_debug("player died!")
    $Player.set_visible(false)
    $Player.set_process(false)
    yield(get_tree().create_timer(1.0), "timeout")
    emit_signal("game_over", score)
