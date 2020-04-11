extends Area2D

export var content : Resource

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	$Sprite.texture = content.texture
	

func _on_body_entered(body:Node) -> void:
	if (body.inventory.add_item(content)):
		queue_free()
	else:
		$full.show()

func _on_body_exited(body:Node) -> void:
	if $full.visible:
		$full.hide()
	
