extends Camera2D

@onready var player_sprite = $"../Player/Sprite2D"

func _ready():
	global_position.y = player_sprite.global_position.y

func _process(_delta):
	global_position.y = player_sprite.global_position.y
