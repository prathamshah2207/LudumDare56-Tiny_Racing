extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = " Lap: " + str(GameManager.lap_count["Player"]) + "/" + str(GameManager.total_laps)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = " Lap: " + str(GameManager.lap_count["Player"]) + "/" + str(GameManager.total_laps)
