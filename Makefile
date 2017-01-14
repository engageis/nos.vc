build:
	docker-compose build

db.migrate: build
	docker-compose run nosvc bundle exec rake db:migrate

run: db.migrate
	docker-compose up -d
