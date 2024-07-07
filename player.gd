extends Area2D

signal pickup # 동전에 닿았을 때 발생할 시그널
signal hurt # 장애물에 닿았을 때 발생할 시그널

@export var speed = 350

var velocity = Vector2.ZERO # 캐릭터의 이동 속도 및 방향
var screen_size = Vector2(480, 720) # 캐릭터의 이동 한계

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# 각 프레임마다 호출됨 - 키보드 입력 확인 / 주어진 방향으로 이동 / 애니메이션 재생
	# 1. 키보드 입력 확인 (프로젝트 설정 - 입력 맵 에서 필요 입력키 확인!!)
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	position += velocity * speed * delta
	# 화면 밖 제한 설정
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# $ 표기를 통해 노드 가져오
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

# 게임 시작
func start():
	# set_process를 통해 _process() 함수 호출 여부 결
	set_process(true)
	position = screen_size / 2
	$AnimatedSprite2D.animation = "idle"

# 게임 종
func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)


func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit()
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
