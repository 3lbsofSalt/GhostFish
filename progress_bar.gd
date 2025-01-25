extends ProgressBar

var player = null;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		if player.health != self.value:
			self.value = player.health

func _ready():
	player = get_parent().get_parent().get_node("PlayerBody2D")
