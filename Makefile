all:
	mkdir /home/arosas-j/data
	mkdir /home/arosas-j/data/wordpress
	mkdir /home/arosas-j/data/mysql
	@docker secret create credentials ./secrets/credentials.txt
	@docker secret create db_password ./secrets/db_password.txt
	@docker secret create db_root_password ./secrets/db_root_password.txt
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

clean:
	@rm -rf ~/data/mysql/*
	@rm -rf ~/data/wordpress/*
	@docker stop $$(docker ps -qa)
	@docker rm $$(docker ps -qa)
	@docker rmi $$(docker images -qa)
	@docker volume rm $$(docker volume ls -q)
	@docker network rm inception_net
	@docker secret rm $$(docker secret ls -q)

.PHONY: all down clean