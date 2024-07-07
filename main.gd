extends Node

@export var coin_scene : PackedScene
@export var playtime = 30

var level = 1
var score = 0
var time_left = 0
var screen_size = Vector2.ZERO
var playing = false

# _ready() 함수는 자동으로 호출됨 (노드 최초 시작시 실행될 코드)
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	$Player.screen_size = screen_size
	$Player.hide() # 게임 시작 전까지는 플레이어 안보이도
	
# 새게임 시작 함
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start()
	$Player.show()
	$GameTimer.start()
	spawn_coins()

# coin 오브젝트 인스턴스 생성
func spawn_coins():
	for i in level + 6:
		# coin 오브젝트 인스턴스 생성
		var c = coin_scene.instantiate()
		# Main 오브젝트의 자식으로 추
		add_child(c)
		# coin 생성 위치를 스크린 내부 + 랜덤으로
		c.screen_size = screen_size
		c.position = Vector2(randi_range(0, screen_size.x), randi_range(0, screen_size.y))

# 남은 coin 확인 함수
func _process(delta):
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		spawn_coins()
