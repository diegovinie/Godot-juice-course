extends Area2D

var attacking: bool = false
@onready var anim = $AnimationPlayer

func _ready() -> void:
	visible = false
	
func _show() -> void:
	visible = true
	anim.play("start")
	
func _hide() -> void:
	anim.play("stop")
	await anim.animation_finished
	visible = false

func shoot() -> void:
	_show()
	$AttackTime.start()
	attacking = true
	# Damage bricks that are already inside the area when we 
	# start attacking
	for body in get_overlapping_bodies():
		body.damage(100)

func _on_AttackTime_timeout() -> void:
	_hide()
	attacking = false

func _on_body_entered(body):
	if not attacking: return
	if body.is_in_group("Bricks"):
		body.damage(100)
