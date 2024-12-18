extends EnemyState

enum States {IDLE, PATROLING, CHASING}

@onready var patrol_cooldown: Timer = $Timer

func _ready():
	call_deferred("set_state", States.IDLE)

func _enter_state(new_state):
	
	match new_state:
		States.IDLE:
			pass
		States.PATROLING:
			pass
