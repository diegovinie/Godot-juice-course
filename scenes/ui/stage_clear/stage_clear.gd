extends Control

signal next()

@onready var time: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Time
@onready var early_bumps: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/EarlyBumps
@onready var late_bumps: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/LateBumps
@onready var perfect_bumps: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/PerfectBumps
@onready var bounces: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Bounces
@onready var score: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Score
@onready var final_score = $VBoxContainer2/HBoxContainer2/FinalScore
var final_score_int: int
#@onready var camera: Camera2D = preload()

var bump_earlylate_multiplicator: int = 500
var bump_perfect_multiplicator: int = 2000
var bounce_multiplicator: int = 10
var nextButtonY: float

func _ready() -> void:
	$VBoxContainer/NextBtn.grab_focus()
	update_stats()
	
	Globals.stats["time"] = 1000
	Globals.stats["bumps_early"] = 200
	Globals.stats["score"] = 1666
	final_score_int = 2305	
	nextButtonY = $VBoxContainer/NextBtn.position.y
	
	hide_stats()
	animate_stats()

func update_stats() -> void:
	var ms = Globals.stats["time"] * 1000
	var seconds: int = int(ms / 1000 )% 60
	var minutes: int = int(ms / 1000 / 60)
	time.text = str(minutes) + ":" + str(seconds)
	early_bumps.text = str(Globals.stats["bumps_early"])
	late_bumps.text = str(Globals.stats["bumps_late"])
	perfect_bumps.text = str(Globals.stats["bumps_perfect"])
	bounces.text = str(Globals.stats["ball_bounces"])
	score.text = str(Globals.stats["score"])
	final_score_int = (Globals.stats["bumps_early"]*bump_earlylate_multiplicator)+ \
		(Globals.stats["bumps_late"]*bump_earlylate_multiplicator)+ \
		(Globals.stats["bumps_perfect"]*bump_perfect_multiplicator)+ \
		(Globals.stats["ball_bounces"]*bounce_multiplicator)+ \
		Globals.stats["score"]
	final_score.text = str(final_score_int)

func animate_stats() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	for child in $VBoxContainer2/HBoxContainer/VBoxContainer2.get_children():
		tween.tween_property(child, "position:x", 0.0, 0.25) \
			.from(-get_viewport_rect().size.x)
		tween.parallel().tween_property(child, "self_modulate:a", 1.0, 0.25).from(0.0)
	
	for i in $VBoxContainer2/HBoxContainer/VBoxContainer3.get_child_count():
		var child = $VBoxContainer2/HBoxContainer/VBoxContainer3.get_child(i)
		var key = Globals.stats.keys()[i]
		tween.tween_method(set_label_number.bind(child), 0, Globals.stats[key], 0.5)
		tween.parallel().tween_property(child, "self_modulate:a", 1.0, 0.05).from(0.0)
		tween.tween_callback(screen_shake.bind(0.4, 20, 10))
		tween.tween_interval(0.25)

	tween.tween_interval(0.25)

	tween.tween_property($VBoxContainer2/HBoxContainer2/Label, "position:x", 0.0, 0.25) \
		.from(-get_viewport_rect().size.x)

	tween.parallel().tween_property($VBoxContainer2/HBoxContainer2/Label, "self_modulate:a", 1.0, 0.25).from(0.0)

	tween.tween_interval(0.25)

	tween.tween_method(set_label_number.bind($VBoxContainer2/HBoxContainer2/FinalScore), 0, final_score_int, 1.0)
	tween.parallel().tween_property($VBoxContainer2/HBoxContainer2/FinalScore, "self_modulate:a", 1.0, 0.05)
	tween.tween_callback(screen_shake.bind(1.0, 30, 25))
	
	tween.tween_property($VBoxContainer/NextBtn, "position:y", nextButtonY, 0.3).from(get_viewport_rect().size.y)
	tween.parallel().tween_property($VBoxContainer/NextBtn, "self_modulate:a", 1.0, 0.1).from(0.0)
	
	tween.tween_callback($VBoxContainer/NextBtn.grab_focus)
		
func hide_stats() -> void:
	for child in $VBoxContainer2/HBoxContainer/VBoxContainer2.get_children():
		child.self_modulate.a = 0.0	

	for child in $VBoxContainer2/HBoxContainer/VBoxContainer3.get_children():
		child.self_modulate.a = 0.0	
		
	$VBoxContainer2/HBoxContainer2/Label.self_modulate.a = 0.0
	$VBoxContainer2/HBoxContainer2/FinalScore.self_modulate.a = 0.0
	$VBoxContainer/NextBtn.self_modulate.a = 0.0
	
func set_label_number(number: int, label: Label) -> void:
	label.set_text(str(number))
	
func screen_shake(duration: float, frequency: float, amplitude: float) -> void:
	if Globals.camera:
		Globals.camera.shake(duration, frequency, amplitude)
			
	

func _on_NextBtn_pressed() -> void:
	emit_signal("next")
	queue_free()
