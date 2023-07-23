extends Sprite2D

func _ready():
	var tween: Tween = create_tween()
	tween.set_ease(tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 0.0, 0.6)
	await tween.finished
	queue_free()
