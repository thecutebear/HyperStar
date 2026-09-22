extends Node2D

# Your three possible 3-floor designs
var floor_designs = [
	preload("res://design1.tscn"),
	preload("res://design2.tscn"),
	preload("res://design3.tscn")
]

# Height of ONE complete 3-floor design.
# Change this if your designs are not 1800 pixels tall.
var chunk_height = 600

# Y-position where the next design will be placed.
var next_chunk_y = -600

# Get the player from the main scene.
@onready var player = $"../Player"


func _ready():
	# Create a few chunks above the starting area.
	generate_chunk()
	generate_chunk()
	generate_chunk()


func _process(delta):
	# If the player gets close to the highest generated area,
	# make another random chunk.
	if player.global_position.y < next_chunk_y + 3600:
		generate_chunk()


func generate_chunk():
	# Choose one of the designs randomly.
	var random_design = floor_designs.pick_random()

	# Make a copy of that scene.
	var new_chunk = random_design.instantiate()

	# Put it above the previous chunk.
	new_chunk.position = Vector2(0, next_chunk_y)

	# Add it to the game.
	add_child(new_chunk)

	# Move the next position upward.
	next_chunk_y -= chunk_height
