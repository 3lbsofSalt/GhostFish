extends Node2D


@onready var fish = get_tree().current_scene.get_node("PlayerBody2D");
@onready var ghost = get_tree().current_scene.get_node("BasicGhost");

@onready var bubblePopSound = $BubblePop
@onready var bubbleGrowSound = $BubbleGrow
@onready var ghostKillSound = $GhostKill


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish.bubblePopSig.connect(playBubblePopSound);
	fish.bubbleGrowSig.connect(playBubbleGrowSound);
	ghost.dieSig.connect(playGhostKillSound);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func playBubblePopSound():
	bubblePopSound.play();
	bubbleGrowSound.stop();
	
func playBubbleGrowSound():
	bubbleGrowSound.play();
	
func playGhostKillSound():
	print("SDGIUHSDLKGS")
	ghostKillSound.play();
