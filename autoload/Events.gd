extends Node

signal base_stat_changed(stat_name, new_value)
signal stat_modded(stat_name, new_value)
signal stat_demodded(stat_name, new_value)

signal item_activated(item_name, slot)
signal item_deactivated(item_name, slot)
signal item_destocked(item_name, slot)
signal item_stocked(item_name, slot)

signal player_damaged(new_hp)
signal player_dead()
