build:
	sudo docker-compose build

db.migrate: build
	sudo docker-compose run nosvc bundle exec rake db:migrate

run: db.migrate
	sudo docker-compose up -d
