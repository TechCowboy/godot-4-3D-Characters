extends Node3D

# Set loop on some animation
@export var _force_loop : PackedStringArray
@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _main_state_machine : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/StateMachine/playback")
@onready var _secondary_action_timer : Timer = $SecondaryActionTimer
var _secondary_action_path = "parameters/StateMachine/Idle/OneShot/active"

func _ready():
	for animation_name in _force_loop:
		var anim : Animation = $bee_bot/AnimationPlayer.get_animation(animation_name)
		anim.loop_mode = Animation.LOOP_LINEAR

func _on_secondary_action_timer_timeout():
	if _main_state_machine.get_current_node() != "Idle": return
	_main_state_machine.travel("HeadMovement")
	_secondary_action_timer.start(randf_range(3.0, 8.0))
	
func idle():
	_main_state_machine.travel("Idle")
	_secondary_action_timer.start()
	
func attack():
	_main_state_machine.travel("Attack")
	
func power_off():
	_main_state_machine.travel("PowerOff")
	_secondary_action_timer.stop()
	
