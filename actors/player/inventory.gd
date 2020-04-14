extends Node

var player

export (String) var item_dir
var active := {
	#instances
	"sword" : null,
	"armor" : null,
	"spell" : null,
}

var stock := {
	"slot0" : "",
	"slot1" : "",
	"slot2" : "",
	"slot3" : "",
	"slot4" : "",
	"slot5" : "",
	"slot6" : "",
	"slot7" : ""
}

var pck_database = {}

func _ready():
	player = get_parent()
