up:
	docker compose up -d

app:
	docker compose exec app ash

ps:
	docker compose ps

recreate:
	docker compose up --build

stop: 
	docker compose stop

down:
	docker compose down

ni:
	docker compose exec app npm install

nd:
	docker compose exec app npm run dev

nw:
	docker compose exec app npm run watch

ci:
	docker compose exec app composer install

dump:
	docker compose exec app composer dump-autoload

cache:
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan route:clear
	docker compose exec app php artisan view:clear

migrate:
	docker compose exec app php artisan migrate:fresh --seed

all:
	@make cache
	@make ni
	@make nd
	@make ci
	@make dump
	@make migrate


create-project:
	docker compose up -d --build
	@make co
	@make ni
	@make nd
	echo ".envファイルを作成して下さい"