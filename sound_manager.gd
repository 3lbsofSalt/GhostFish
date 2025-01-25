extends Node2D


@onready var fish = get_tree().current_scene.get_node("PlayerBody2D");
@onready var ghosts = get_tree().get_nodes_in_group('Ghost');

@onready var bubblePopSound = $BubblePop
@onready var bubbleGrowSound = $BubbleGrow
@onready var ghostKillSound = $GhostKill


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish.bubblePopSig.connect(playBubblePopSound);
	fish.bubbleGrowSig.connect(playBubbleGrowSound);
	for ghost in ghosts:
		if ghost.is_class('Area2D'):
			ghost.death_sound_connected = true;
			ghost.dieSig.connect(playGhostKillSound);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for ghost in get_tree().get_nodes_in_group('Ghost'):
		if ghost.is_class('Area2D') and not ghost.death_sound_connected and ghost.has_signal('dieSig'):
			ghost.death_sound_connected = true;
			ghost.dieSig.connect(playGhostKillSound);
	pass
	
	
func playBubblePopSound():
	bubblePopSound.play();
	bubbleGrowSound.stop();
	
func playBubbleGrowSound():
	bubbleGrowSound.play();
	
func playGhostKillSound():
	print("SDGIUHSDLKGS")
	ghostKillSound.play();
