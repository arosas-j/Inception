DCOMPOSE = docker compose -f srcs/docker-compose.yml
VOLUMES = /home/arosas-j/data/wordpress /home/arosas-j/data/mysql

.PHONY: all setup stop down force-rebuild clean fclean restart re

# Build and start the containers
all: setup
	$(DCOMPOSE) up --build -d

# Create necessary directories
setup:
	mkdir -p $(VOLUMES)

# Stop containers
stop:
	$(DCOMPOSE) stop

# Remove containers
down:
	$(DCOMPOSE) down

# Force rebuild with --no-cache
force-rebuild: setup
	$(DCOMPOSE) build --no-cache
	$(DCOMPOSE) up -d

# Remove containers and volumes
clean:
	$(DCOMPOSE) down --volumes

# Remove everything
fclean:
	$(DCOMPOSE) down --rmi all --volumes

# Remove the containers and restart
restart: down all

# Rebuild the project
re: fclean force-rebuild