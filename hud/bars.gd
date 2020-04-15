extends VBoxContainer


func _ready():
	Events.connect("base_stat_changed", self, "_on_stat_changed")
	Events.connect("stat_demodded", self, "_on_stat_changed")
	Events.connect("stat_modded", self, "_on_stat_changed")

func _on_stat_changed(stat, value) -> void:
	if stat == "max_hp":
		$hp/hp_bar.max_value = value
	elif stat == "curr_hp":
		$hp/hp_bar.value = value
	elif stat == "max_mp":
		$mp/mp_bar.max_value = value
	elif stat == "curr_mp":
		$mp/mp_bar.value = value
	elif stat == "lv":
		$lv/lv_text.text = "lv: "+ str(value)
	elif stat == "curr_exp":
		$lv/curr_exp.text = str(value)
	elif stat == "next_exp":
		$lv/next_exp.text = "/ "+str(value)


func _on_exp_changed():
	prints($lv/exp.value,$lv/exp.max_value)
