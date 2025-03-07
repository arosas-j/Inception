# Define paths
DCOMPOSE = docker compose -f srcs/docker-compose.yml
VOLUMES = /home/arosas-j/data/wordpress /home/arosas-j/data/mysql

.PHONY: all setup stop down force-rebuild clean fclean restart re

# Build and start the containers
all: setup
	$(DCOMPOSE) up --build -d

# Setup: Create necessary directories
setup:
	mkdir -p $(VOLUMES)

# Stop containers without removing volumes or images
stop:
	$(DCOMPOSE) stop

# Remove containers, keeping images and volumes
down:
	$(DCOMPOSE) down

# Force rebuild with --no-cache
force-rebuild: setup
	$(DCOMPOSE) build --no-cache
	$(DCOMPOSE) up -d

# Remove containers and volumes (but keep images)
clean:
	$(DCOMPOSE) down --volumes

# Remove everything (containers, volumes, images)
fclean:
	$(DCOMPOSE) down --rmi all --volumes

# Remove the containers and restart them again
restart: down all

# Rebuild the project
re: fclean force-rebuild