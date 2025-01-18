.PHONY: up down ps shell logs build build-no-cache prune

# コンテナを起動
up:
	docker compose up -d

# コンテナを停止
down:
	docker compose down

# コンテナの状態確認
ps:
	docker compose ps

# コンテナのシェルに入る（appはサービス名なので、必要に応じて変更してください）
shell:
	docker compose exec app sh

# コンテナのログを表示
logs:
	docker compose logs -f

# イメージをビルド
build:
	docker compose build

# キャッシュを使用せずにイメージをビルド
build-no-cache:
	docker compose build --no-cache

# 全てのコンテナ、ボリューム、ネットワーク、未使用イメージを削除
prune:
	docker compose down --volumes --remove-orphans
	docker system prune -af --volumes 