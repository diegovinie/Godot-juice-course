extends Area2D

func _ready() -> void:
	visible = false
	
func _show() -> void:
	visible = true
	
func _hide() -> void:
	visible = false

func shoot() -> void:
	_show()
	var bodies = get_overlapping_bodies()
	for body in bodies:
		body.damage(100)
	$AttackTime.start()

func _on_AttackTime_timeout() -> void:
	_hide()
