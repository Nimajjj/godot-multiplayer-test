extends Control

@onready var LogsLabel = $LogsLabel


func _ready():
	Logs.server_side = self
	
	
func add_log(txt: String, _log_level: String = Logs.LVL_INFO) -> void:
	LogsLabel.text += txt
