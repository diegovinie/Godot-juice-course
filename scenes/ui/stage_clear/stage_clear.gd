extends Control

signal next()

@onready var time: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Time
@onready var bumps: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Bumps
@onready var bounces: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Bounces
@onready var score: Label = $VBoxContainer2/HBoxContainer/VBoxContainer3/Score

func _ready() -> void:
	$VBoxContainer/NextBtn.grab_focus()

func update_stats() -> void:
	var stats = {
	"score": 0,
	"bumps_meh": 0,
	"bumps_good": 0,
	"bumps_perfect": 0,
	"time": 0.0,
	"ball_bounces": 0
}
	time.text = str(stats["time"])
	bumps.text = str(stats["time"])
	bounces.text = str(stats["ball_bounces"])
	score.text = str(stats["score"])

func _on_NextBtn_pressed() -> void:
	emit_signal("next")
	queue_free()
