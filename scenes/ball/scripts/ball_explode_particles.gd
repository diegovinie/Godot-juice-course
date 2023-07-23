extends GPUParticles2D

func _ready():
	emitting = true
	$InnerExplosionParticles.emitting = true
	$Timer.start(lifetime + 1.0)
	

func _on_timer_timeout():
	queue_free()
