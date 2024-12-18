class_name PlayerStatComponent
extends PlayerComponent

# TODO receive signal connect on player jumped

func has_stamina_for(cost: float) -> bool:
	return player.stats.stamina >= cost
