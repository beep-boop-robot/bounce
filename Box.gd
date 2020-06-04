extends Node2D

signal hit_correct()
signal hit_incorrect()
signal hit_invalid()

export var hit_direction = Vector2(1, 0)
export var invalid = false

# Called when the node enters the scene tree for the first time.
func _ready():
    if hit_direction.x > 0:
        $AnimatedSprite.play("right")
    else:
        $AnimatedSprite.play("left")
    if invalid:
        $AnimatedSprite.play("invalid")


func _on_Area2D_body_entered(body):
    var velocity = body.get("velocity")
    if invalid:
        emit_signal("hit_invalid")    
    elif velocity:
        if velocity.x > 0:
            if hit_direction.x > 0:
                emit_signal("hit_correct")
            else:
                emit_signal("hit_incorrect")
        elif velocity.x < 0:
            if hit_direction.x < 0:
                emit_signal("hit_correct")
            else:                
                emit_signal("hit_incorrect")
    # todo animate
    queue_free()
