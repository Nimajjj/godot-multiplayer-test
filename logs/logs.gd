extends Node

const LVL_DEBUG: String = "DEBUG"
const LVL_INFO: String = "INFO"
const LVL_WARN: String = "WARN"
const LVL_FATAL: String = "FATAL"

var server_side: Control = null
var headless: bool = false


@rpc("any_peer")
func add(txt: String, log_level: String = LVL_INFO):
	var time: Dictionary = Time.get_time_dict_from_system()
	var formatted_time: String = "{0}:{1}:{2}".format([time.hour, time.minute, time.second])
	
	var caller_id = multiplayer.get_remote_sender_id()
	if caller_id == 0: caller_id = "server"
	
	var text: String = "{0} - [{1}] - ({2}) : {3}\n".format([formatted_time, log_level, caller_id, txt])
	
	if server_side != null && !headless:
		server_side.add_log(text, log_level)
	else:
		print(text)
