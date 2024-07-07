extends Area2D

var screen_size = Vector2.ZERO

func pickup():
	# 노드를 제거하는 메서드 사용
	# 모든 자식 노드와 함께 안전하게 제거 및 메모리에서 삭제 (삭제할 대기열 큐에 추가)
	queue_free()
