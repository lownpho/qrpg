extends Area2D

var damage = 20 + randi()%5


func _on_attack_area_body_entered(body):
	pass

func _physics_process(delta):
	if $cd.is_stopped() and  visible and get_overlapping_bodies().size()!=0:
		get_overlapping_bodies()[0].take_damage(damage)
		$cd.start()
		hide()
		
func _on_cd_timeout():
	show()
