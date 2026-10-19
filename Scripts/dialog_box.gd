extends Control

@export var character_time : float
@onready var timer: Timer = %Timer

var dialog_progression: int
var can_continue_dialog : bool = false
var characters_to_count : int = 0
var final_boat : bool = false
@export var dialog_bleeps_counter : int = 3

signal tut_wasd
signal tut_map
signal tut_done
signal total_dialog_end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	#dialog_progression = 1
	#open_dialog_screen(dialog_progression)
	#timer.autostart = false
	pass

func _input(event: InputEvent) -> void:
	if !$".".is_visible_in_tree():
		return
	if !can_continue_dialog:
		return
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			dialog_progression += 1
			open_dialog_screen()
			pass
		#if event.keycode == KEY_0:
			#dialog_progression = 58
			#open_dialog_screen()
			#pass
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
			tut_wasd.emit()
			pass
		4:
			%Name.text = "Manager"
			%Dialog.text = "If you ever feel lost, press M to open your map I've given you! Feel free to draw on it as well holding LMB and dragging!. They're cheap enough to print out."
			pass
		5:
			%Name.text = "Manager"
			%Dialog.text = "If you run out of room to draw, you can always press RMB to clear all of your beautiful artwork!"
			pass
		6:
			dialog_end()
			tut_map.emit()
			pass
		7:
			%Name.text = "Manager"
			%Dialog.text = "See? You're a seaborn natural already! Just gotta wait for the next distress call now."
			pass
		8:
			%Name.text = "Manager"
			%Dialog.text = "Well..."
		9:
			%Name.text = "Manager"
			%Dialog.text = "Gonna go now... Good luck!"
			pass
				
		10:
			dialog_end()
			tut_done.emit()
		11:
			%Name.text = "Jarob"
			%Dialog.text = "Dude! The weather got crazy out here! I was just trying to get some [i]fish n’ chips you know?[/i] Can’t even see a thing past this [i]island[/i] anymore!"
			pass
		12:
			%Name.text = "Jarob"
			%Dialog.text = "You should get some while you’re here though, the fish n’ chips is to die for!"
			pass
		13:
			%Name.text = "Jarob"
			%Dialog.text = "But like… Don’t actually die… please? [wave]I really need your help.[/wave]"
			pass
		14:
			dialog_end()
			pass
		15:
			%Name.text = "Jarob"
			%Dialog.text = "You made it! Did you try out the chip n' fish shop? Either way, I need to get to Drowned port please!"
			pass	
		16:
			dialog_end()
			pass	
		17:
			%Name.text = "Fishsquire"
			%Dialog.text = "Hey… I ended up a little distracted by these really… really pretty merladies… I have no idea where I am to be honest?"
			pass
		18:
			%Name.text = "Fishsquire"
			%Dialog.text = "I love a beautiful blubbery girl... [wave]so warm...[/wave]"
			pass
		19: 
			%Name.text = "Fishsquire"
			%Dialog.text = "I think there’s some kind of really beat up [i]castle[/i] opposite me? [i]A lot of water[/i] surrounding me as well…"
			pass
		20:
			dialog_end()
			pass
		21: 
			%Name.text = "Fishsquire"
			%Dialog.text = "[wave]So... They weren't mermaids at all?... man... just to [b]Rich Port[/b] I guess...[/wave]"
			pass
		22:
			dialog_end()
			pass
		23:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "Oh thank goodness you responded!"
			pass
		24:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "The customer service for these waters is absolutely ridiculous!"
			pass
		25:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "I’ve been stuck at this [i]tiny castle[/i] for [shake]10 minutes[/shake] now and nobody has come to get me!"
			pass
		26:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "You better be fast or I’ll be speaking to your supervisor!"
			pass
		27:
			dialog_end()
			pass
		28:
			%Name.text = "Filobena-Anne Schkrungle"
			%Dialog.text = "You were... [wave]timely enough...[/wave] I suppose... To [b]Rich Port[/b], any time today please?"
			pass
		29:
			dialog_end()
			pass
		30:
			%Name.text = "Millermen"
			%Dialog.text = "Good evening, it appears that we lost signal after trying to do some readings for the [i]windmills down south[/i], east of one of the castles."
			pass
		31:
			%Name.text = "Millermen"
			%Dialog.text = "It’s been hard to navigate to any of the ports nearby so some assistance would be well appreciated."
			pass
		32:
			dialog_end()
			pass
		33:
			%Name.text = "Millermen"
			%Dialog.text = "Much appreciated. We just need to head over to [b]Drowned Port.[/b]"
			pass
		34:
			dialog_end()
			pass			
		35:
			%Name.text = "William?"
			%Dialog.text = "Ga ga ga ga… gaaaa. Aba ba ba ba."
			pass
		36:
			%Name.text = ""
			%Dialog.text = "(It appears this person must have found the [i]Fountain of Youth[/i]...)"
			pass
		37:
			dialog_end()
			pass
		38:
			%Name.text = "William?"
			%Dialog.text = "Gaa.. goo ga ga gwaaah ga ga!"
			pass
		39:
			%Name.text = ""
			%Dialog.text = "(The baby seems to be pointing in the direction of [b]Port Done...[/b])"
			pass
		40:
			dialog_end()
			pass
		41:
			%Name.text = "Squeeb"
			%Dialog.text = "[shake]HELP![/shake]"
			pass
		42:
			%Name.text = "Squeeb"
			%Dialog.text = "[shake][b]HELP MEEEEE!!![/b][/shake]"
			pass
		43:
			%Name.text = "Squeeb"
			%Dialog.text = "[shake]HELP I GOT STUCK IN THAT [i]PORTA POTTY[/i] UP NORTH! I CAN'T GET MYSELF UNSTUCK![/shake]"
			pass
		44:
			%Name.text = "Squeeb"
			%Dialog.text = "[shake]IT STINKS SO BAD![/shake]"
			pass
		45:
			%Name.text = "Squeeb"
			%Dialog.text = "[shake][i]HEEEEEEEEEEEEEEEEEEEEEEEEEEEEELP–[/i][/shake]"
			pass
		46:
			%Name.text = ""
			%Dialog.text = "(The line went cold...)"
			pass
		47:
			dialog_end()
			pass
		48:
			%Name.text = "Squeeb"
			%Dialog.text = "THANK GOD YOU GOT ME! I’M GONNA BE LATE TO MY INTERVIEW. TO [b]PORT SMOKEY[b] [shake]NOW!!!![/shake]"
			pass
		49:
			dialog_end()
			pass
		50:
			%Name.text = "Gariana Andy"
			%Dialog.text = "Heeeeyyyyy~ So I think there’s some weird guy on the [i]trash island[/i] east of the beach."
			pass
		51:
			%Name.text = "Gariana Andy"
			%Dialog.text = "I think he might be… stuck? He seems to be enjoying himself though."
			pass
		52:
			%Name.text = "Gariana Andy"
			%Dialog.text = "He’s calling himself the king of the trash island?"
			pass
		53:
			%Name.text = "Gariana Andy"
			%Dialog.text = "He’s like super loud."
			pass
		54:
			%Name.text = "Gariana Andy"
			%Dialog.text = "Like..."
			pass
		55:
			%Name.text = "Gariana Andy"
			%Dialog.text = "[i][b]Super Loud.[/b][/i]"
			pass
		56:
			%Name.text = "Gariana Andy"
			%Dialog.text = "We had no idea what to do so like..."
			pass
		57:
			%Name.text = "Gariana Andy"
			%Dialog.text = "Can you like help or something?"
			pass
		58:
			%Name.text = "Gariana Andy"
			%Dialog.text = "K'thanks byeeeee~"
			pass
		59:
			dialog_end()
			pass
		60:
			%Name.text = "King of Trash Island"
			%Dialog.text = "[wave]Who told you you can disturb me here at my domicile! This is a free gaff![/wave]"
			pass
		61:
			%Name.text = "King of Trash Island"
			%Dialog.text = "[wave]I guess it’s… cold… if you can take me to [b]Port Done…[/b][/wave]"
			pass
		62:
			dialog_end()
			pass
		63:
			%Name.text = "Scotchman Barry (63)"
			%Dialog.text = "Och ye finally answered! Was startin’ tae winder if the line was aff!"
			pass
		64:
			%Name.text = "Scotchman Barry (63)"
			%Dialog.text = "Look our boat is like defo knackered, cannae get the thing tae run at ah!"
			pass
		65:
			%Name.text = "Scotchman Barry (63)"
			%Dialog.text = "Can ye gie us a hand oot? Any help at ah would be grand. We’re doon sooth, at like a [i]huge castle[/i] like. Think I got a gander of a [i]shipwreck[/i] up north n' ah."
			pass
		66:
			%Name.text = "Scotchman Barry (63)"
			%Dialog.text = "Cheers pal!"
			pass
		67:
			dialog_end()
			pass
		68:
			%Name.text = "Scotchman Barry (63)"
			%Dialog.text = "Aye you found us lad! We just need tae get back tae [b]Port Smokey[/b] and we’re sorted!"
			pass
		69:
			dialog_end()
			final_boat = true
		_:
			%Name.text = "Big Beautiful bouncin baby boy"
			%Dialog.text = " NO MORE GAME NOW BYE ! "
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
	get_tree().paused = false
	pass

func open_dialog_screen():
	can_continue_dialog = true
	if not visible:
		show()
		get_tree().paused = true
	%Dialog.visible_characters = 0
	dialog_tree(dialog_progression)
	pass
	
func play_character_sound():
	if !can_continue_dialog:
		return
	%CharacterAudio.play()
	pass
