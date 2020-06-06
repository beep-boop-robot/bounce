extends KinematicBody2D

signal off_screen()

export var max_accelartion = 1.0
export var drag = 0.05
export var acceleration_delta = 0.1
export var bounce = 1.25

export var max_acceleration_delta = 2.0
export var max_bounce = 5.0
export var min_drag = 0.01

var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_pressed("ui_right"):   
        velocity += Vector2(acceleration_delta,0)    
    elif Input.is_action_pressed("ui_left"):
        velocity -= Vector2(acceleration_delta, 0)
    elif velocity.x < 0:
        velocity +=  Vector2(drag, 0) # todo lerp? 
    elif velocity.x > 0:
        velocity -=  Vector2(drag, 0) # todo lerp? 
    
    velocity = Vector2(max(min(velocity.x, max_accelartion), -max_accelartion), 0)   
    
    if velocity.x > 0:          
        $AnimatedSprite.play("right")
    else:        
        $AnimatedSprite.play("left")
    
    var collision = move_and_collide(velocity)
    
    if collision:
        $BounceSound.play()
        velocity = velocity.bounce(collision.normal) * bounce


func _on_VisibilityNotifier2D_screen_exited():
    emit_signal("off_screen")
    
func increase():    
    acceleration_delta = min(acceleration_delta * 1.2, max_accelartion)
    bounce = min(bounce * 1.25, max_bounce)
    drag = max(drag * 0.8, min_drag)
