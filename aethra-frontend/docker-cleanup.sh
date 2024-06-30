#!/bin/bash
# Clean up unused Docker resources
sudo docker system prune -a -f
sudo docker volume prune -f
sudo docker network prune -f