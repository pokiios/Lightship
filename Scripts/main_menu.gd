extends Control

@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton

@export var hover_scale : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	print ("playing! yay!")


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
	pass # Replace with function body.
