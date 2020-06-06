extends Node2D


var MainMenu = preload("res://MainMenu.tscn")
var GameOver = preload("res://GameOver.tscn")
var GameWorld = preload("res://World.tscn")
var GameUI = preload("res://UI.tscn")

var w = null
var ui = null
var gos = null

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _run_game():    
    w = GameWorld.instance()
    ui = GameUI.instance()
    w.connect("set_multiplyer", ui, "_on_World_set_multiplyer")
    w.connect("set_score", ui, "_on_World_set_score")
    w.connect("game_over", self, "_on_World_game_over")
    add_child(w)
    add_child(ui)
    
func _on_GameOver_retry():
    $MainMenuSound.play()
    gos.queue_free()
    _run_game()

func _on_World_game_over(score):
    gos = GameOver.instance()
    gos.score = w.score
    gos.connect("retry", self, "_on_GameOver_retry")
    w.queue_free()
    ui.queue_free()
    add_child(gos)

func _on_MainMenu_start():
    $MainMenuSound.play()
    $MainMenu.queue_free()
    _run_game()
