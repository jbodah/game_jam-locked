extends AnimatedSprite

func _ready():
	$Timer.one_shot = false
	$Timer.connect('timeout', self, 'on_timeout')
	$Timer.start(2)
	on_timeout()

func on_timeout():
	frame = 0
	play('default')
