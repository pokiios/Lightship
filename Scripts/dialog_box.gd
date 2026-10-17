extends Control

signal is_dialog_open

@export var character_time : float
@onready var timer: Timer = %Timer

var dialog_progression: int
var can_continue_dialog : bool = false
var characters_to_count : int = 0
@export var dialog_bleeps_counter : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_progression = 1
	open_dialog_screen(dialog_progression)
	timer.autostart = false

func _input(event: InputEvent) -> void:
	if !$".".is_visible_in_tree():
		return
	if !can_continue_dialog:
		return
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			dialog_progression += 1
			open_dialog_screen(dialog_progression)
			pass
		if event.keycode == KEY_0:
			dialog_progression = 28
			open_dialog_screen(dialog_progression)
			pass
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
			dialog_end()
		4:
			%Name.text = "Manager"
			%Dialog.text = "See! You're a seaborn natural! Well, my shifts over so... Good luck!"
			pass
		5:
			dialog_end()
			pass
		6:
			%Name.text = "Jarob"
			%Dialog.text = "Dude! The weather got crazy out here! I was just trying to get some [i]fish n’ chips you know?[/i] Can’t even see a thing past this [i]island[/i] anymore!"
			pass
		7:
			%Name.text = "Jarob"
			%Dialog.text = "You should get some while you’re here though, the fish n’ chips is to die for!"
			pass
		8:
			%Name.text = "Jarob"
			%Dialog.text = "But like… Don’t actually die… please? I really need your help."
			pass
		9:
			dialog_end()
			pass
		10:
			%Name.text = "Squeeb"
			%Dialog.text = "HELP!"
			pass
		11:
			%Name.text = "Squeeb"
			%Dialog.text = "[b]HELP MEEEEE!!![/b]"
			pass
		12:
			%Name.text = "Squeeb"
			%Dialog.text = "HELP I GOT STUCK IN THAT [i]PORTA POTTY[/i] UP NORTH! I CAN'T GET MYSELF UNSTUCK!"
			pass
		13:
			%Name.text = "Squeeb"
			%Dialog.text = "IT STINKS SO BAD!"
			pass
		14:
			%Name.text = "Squeeb"
			%Dialog.text = "[i]HEEEEEEEEEEEEEEEEEEEEEEEEEEEEELP–[/i]"
			pass
		15:
			%Name.text = ""
			%Dialog.text = "(The line went cold...)"
			pass
		16:
			dialog_end()
			pass
		17:
			%Name.text = "Millermen"
			%Dialog.text = "Good evening, it appears that we lost signal after trying to do some readings for the [i]windmills down south[/i], east of one of the castles."
			pass
		18:
			%Name.text = "Millermen"
			%Dialog.text = "It’s been hard to navigate to any of the ports nearby so some assistance would be well appreciated."
			pass
		19:
			dialog_end()
			pass
		20:
			%Name.text = "Fishsquire"
			%Dialog.text = "Hey… I ended up a little distracted by these really… really pretty merladies… I have no idea where I am to be honest?"
			pass
		21: 
			%Name.text = "Fishsquire"
			%Dialog.text = "I think there’s some kind of really beat up [i]castle[/i] opposite me? [i]A lot of water[/i] surrounding me as well…"
			pass
		22:
			dialog_end()
			pass
		23:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "Oh thank goodness you responded!"
		24:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "The customer service for these waters is absolutely ridiculous!"
		25:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "I’ve been stuck at this bridge for 10 minutes now and nobody has come to get me!"
		26:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "You better be fast or I’ll be speaking to your supervisor!"
		27:
			dialog_end()
			pass
		28:
			%Name.text = "Gariana Andy"
			%Dialog.text = "Heeeeyyyyy~ So I think there’s some weird guy on the [i]trash island[/i] east of the beach."
			pass
		29:
			%Name.text = "Gariana Andy"
			%Dialog.text = "I think he might be… stuck? He seems to be enjoying himself though."
			pass
		30:
			%Name.text = "Gariana Andy"
			%Dialog.text = "He’s calling himself the king of the trash island?"
			pass
		31:
			%Name.text = "Gariana Andy"
			%Dialog.text = "He’s like super loud."
			pass
		32:
			%Name.text = "Gariana Andy"
			%Dialog.text = "Like..."
			pass
		33:
			%Name.text = "Gariana Andy"
			%Dialog.text = "[i][b]Super Loud.[/b][/i]"
			pass
		34:
			%Name.text = "Gariana Andy"
			%Dialog.text = "We had no idea what to do so like..."
			pass
		35:
			%Name.text = "Gariana Andy"
			%Dialog.text = "Can you like help or something?"
			pass
		36:
			%Name.text = "Gariana Andy"
			%Dialog.text = "K'thanks byeeeee~"
			pass
		37:
			dialog_end()
		_:
			pass
	scroll_text()
	pass

# Scrolls the text so that it is already aligned but 
func scroll_text():
	timer.autostart = true
	characters_to_count = %Dialog.get_total_character_count()
	for characters in characters_to_count+1:
		await timer.timeout
		if characters % dialog_bleeps_counter == 0:
			# play sound stuff here
			play_character_sound()
			pass
		%Dialog.visible_characters = characters
		if characters == characters_to_count:
			timer.autostart = false
		pass

# Triggers when dialog ends, stops it from going too far
func dialog_end():
	can_continue_dialog = false
	hide()
	pass

func open_dialog_screen(position: int):
	can_continue_dialog = true
	show()
	%Dialog.visible_characters = 0
	dialog_tree(position)
	pass
	
func play_character_sound():
	if !can_continue_dialog:
		return
	%CharacterAudio.play()
	pass
