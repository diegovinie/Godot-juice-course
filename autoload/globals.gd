extends Node

var stats = {
	"score": 0,
	"bumps_meh": 0,
	"bumps_good": 0,
	"bumps_perfect": 0,
	"time": 0.0,
	"ball_bounces": 0
}

func _ready() -> void:
	pass

func reset_stats() -> void:
	for key in stats.keys():
		stats[key] = 0
