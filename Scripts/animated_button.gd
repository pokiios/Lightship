extends Button
class_name AnimatedButton

# Exports
@export_category("Hover")
@export var hover_scale : Vector2 = Vector2(1.0,1.0)
@export var hover_animation_length : float = 0.1
@export var unhover_animation_length : float = 0.1

@export_category("Press")
@export var press_scale : Vector2 = Vector2(0.95,0.95)
@export var press_animation_length_1 : float = 0.1
@export var press_animation_length_2 : float = 0.1

var animation_tween : Tween

func _ready() -> void:
	pressed.connect(_button_press)
	mouse_entered.connect(_button_hover)
	mouse_exited.connect(_button_unhover)
	
	pivot_offset_ratio = Vector2.ONE / 2.0

func _button_press():
	if animation_tween:
		animation_tween.kill()
	animation_tween = create_tween().set_trans(Tween.TRANS_SINE)
	animation_tween.tween_property(self, "scale", press_scale, press_animation_length_1)
	animation_tween.chain().tween_property(self,"scale", hover_scale, press_animation_length_2)
	pass

func _button_hover():
	# if exists kills it
	if animation_tween:
		animation_tween.kill()
	# create tween
	animation_tween = create_tween().set_trans(Tween.TRANS_SINE)
	
	animation_tween.tween_property(self, "scale", hover_scale, hover_animation_length)
	pass

func _button_unhover():
	# if exists kills it
	if animation_tween:
		animation_tween.kill()
	# create tween
	animation_tween = create_tween().set_trans(Tween.TRANS_SINE)
	
	animation_tween.tween_property(self, "scale", Vector2.ONE, unhover_animation_length)
	pass
