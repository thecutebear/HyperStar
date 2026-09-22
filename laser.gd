extends Node2D

# SETTINGS YOU CAN CHANGE FOR EACH LASER
@export var wait_time: float = 2.0
@export var fire_time: float = 1.0
@export var start_delay: float = 0.0

# Connect the code to the beam and collision shape
@onready var beam = $Line2D
@onready var hitbox = $Area2D/CollisionShape2D


func _ready():
	laser_cycle()


func laser_cycle():
	# Make sure the laser starts OFF
	beam.visible = false
	hitbox.set_deferred("disabled", true)

	# Wait before this laser begins its cycle
	await get_tree().create_timer(start_delay).timeout

	# Repeat forever
	while true:
		# LASER OFF
		beam.visible = false
		hitbox.set_deferred("disabled", true)

		# Stay off
		await get_tree().create_timer(wait_time).timeout

		# LASER ON
		beam.visible = true
		hitbox.set_deferred("disabled", false)

		# Stay on
		await get_tree().create_timer(fire_time).timeout


func _on_area_2d_body_entered(body):
	# Restart the level if the player touches an active laser
	if body.name == "Player":
		get_tree().reload_current_scene()
