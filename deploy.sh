#!/bin/bash    
#             ./deploy.sh               chmod +x deploy.sh
set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
APP_NAME="app_blog"
SERVER_IP="159.69.108.58"
REMOTE_PATH="/opt/app_blog/"
USER="root"

echo "--- Starting Deployment for $APP_NAME ---"

# 1. Sinchronization of files using rsync
echo "[1/3] Syncing files..."
rsync -avz --delete \
      --exclude '.git/' \
      --exclude 'tmp/' \
      --exclude 'log/' \
      --exclude 'node_modules/' \
      --exclude 'public/packs/' \
      --exclude 'public/assets/' \
      --exclude 'storage/' \
      ./ $USER@$SERVER_IP:$REMOTE_PATH

# 2. Удаленное выполнение через SSH
echo "[2/3] Checking migrations and updating containers..."
ssh $USER@$SERVER_IP << EOF
  cd $REMOTE_PATH

  # Поднимаем или обновляем контейнеры
  docker compose up -d
  
  # Даем Rails 5 секунд, чтобы инициализировать соединение с БД (Risk Control)
  echo ">>> Waiting for containers to initialize..."
  sleep 5

  # Проверка миграций через статус БД
  MIGRATIONS_PENDING=\$(docker compose exec -T web bundle exec rails db:migrate:status | grep "  down  " | wc -l)

  if [ "\$MIGRATIONS_PENDING" -gt 0 ]; then
    echo ">>> Found \$MIGRATIONS_PENDING pending migrations. Running db:migrate..."
    docker compose exec -T web bundle exec rails db:migrate
  else
    echo ">>> No new migrations found."
  fi

  # 3. Перезапуск приложения
  echo "[3/3] Restarting application services..."
  docker compose restart web

  # Очистка ТОЛЬКО неиспользуемых образов (Dangling Images)
  # Это освободит место, но НИКОГДА не тронет волюмы с БД или Storage.
  echo ">>> Cleaning up old docker images..."
  docker image prune -f
EOF

echo "--- Deployment Complete ---"