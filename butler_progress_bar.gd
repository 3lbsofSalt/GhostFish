extends ProgressBar

var butler = null;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	butler = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if butler != null:
		if self.value != butler.health:
			print("before", self.value)
			self.value = butler.health
			print("after", self.value)
			
		#print('butler health ', butler.health)
