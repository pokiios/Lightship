extends Control

signal is_dialog_open

@export var character_time : float
@onready var timer: Timer = %Timer

var dialog_progression: int
var can_continue_dialog : bool = false
var characters_to_count : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open_dialog_screen()
	dialog_progression = 0
	%Name.text = ""
	%Dialog.text = ""
	is_dialog_open.connect(open_dialog_screen)
	timer.autostart = false

func _unhandled_input(event: InputEvent) -> void:
	if !$".".is_visible_in_tree():
		return
	if !can_continue_dialog:
		return
	if event.is_action_pressed("ui_accept"):
		dialog_progression += 1
		dialog_tree(dialog_progression)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dialog_tree(dialog_progression: int):
	match dialog_progression:
		1:
			%Name.text = "Manager"
			%Dialog.text = "Hey! I heard it's your first day on the job! I'll show you the ropes a little so we can get you on the job as soon as possible!"
		2:
			%Name.text = "Manager"
			%Dialog.text = "Move around using WASD, if you get near enough to someone they'll be able to follow along! Try to get as close to a port as possible and you're gravy!"
			pass
		3:
			%Name.text = "Manager"
			%Dialog.text = "See! You're a seaborn natural! Well, my shifts over so... Good luck!"
			pass
		4:
			dialog_end()
			pass
		5:
			pass
		_:
			pass
	scroll_text()
	pass

# Scrolls the text so that it is already aligned but 
func scroll_text():
	timer.autostart = true
	characters_to_count = %Dialog.get_total_character_count()
	for characters in characters_to_count:
		await timer.timeout
		%Dialog.visible_characters = characters
		if characters == characters_to_count:
			timer.autostart = false
		pass

# Triggers when dialog ends, stops it from going too far
func dialog_end():
	can_continue_dialog = false
	hide()
	pass

func open_dialog_screen():
	can_continue_dialog = true
	show()
	%Dialog.visible_characters = 0
	pass
