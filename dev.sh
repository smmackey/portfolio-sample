#!/bin/bash

set -e

# Change this if your Django service has a different name in docker-compose.yml
SERVICE="web"

function usage() {
  echo "Usage: ./dev.sh [up|down|bash|manage|migrate|logs|lint|format|test]"
  exit 1
}

COMMAND=$1
shift || true

case "$COMMAND" in
  up)
    echo "Starting docker container..."
    docker-compose up -d --build
    echo "Running migrations..."
    docker-compose exec $SERVICE python manage.py migrate
    echo "App is up at http://localhost:8000"
    ;;
  down)
    echo "Stopping docker containers..."
    docker-compose down
    ;;
  bash)
    docker-compose exec $SERVICE bash
    ;;
  manage)
    docker-compose exec $SERVICE python manage.py "$@"
    ;;
  migrate)
    docker-compose exec $SERVICE python manage.py migrate
    ;;
  logs)
    docker-compose logs -f
    ;;
  lint)
    docker-compose exec $SERVICE ruff check . --fix
    ;;
  format)
    docker-compose exec $SERVICE ruff format .
    ;;
  test)
    docker-compose exec $SERVICE pytest tests.py
    ;;
  *)
    usage
    ;;
esac
