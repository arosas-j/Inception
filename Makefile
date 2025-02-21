all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

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