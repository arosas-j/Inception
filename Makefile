# Define paths
DCOMPOSE = docker compose -f srcs/docker-compose.yml
VOLUMES = /home/arosas-j/data/wordpress /home/arosas-j/data/mysql

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

# Remove containers and volumes (but keep images)
clean:
	$(DCOMPOSE) down --volumes

# Remove everything (containers, volumes, images)
fclean:
	$(DCOMPOSE) down --rmi all --volumes

# Restart the project
re: fclean all