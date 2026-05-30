#!/bin/bash    
#             ./deploy.sh               chmod +x deploy.sh
set -e 

# --- ANSI Цвета для терминала ---
CLR_RESET="\033[0m"
CLR_SUCCESS="\033[1;32m" 
CLR_INFO="\033[1;34m"    
CLR_WARN="\033[1;33m"    

# --- Конфигурация конвейера ---
APP_NAME="app_blog"
SERVER_IP="46.225.145.50"
REMOTE_PATH="/opt/app_blog/"
USER="root"

echo -e "${CLR_INFO}🚀 [СТАРТ] Анализ изменений для $APP_NAME...${CLR_RESET}"
echo "========================================================================="

# [ПРОДВИНУТЫЙ РИСК-КОНТРОЛЬ] Проверяем, есть ли вообще изменения в коде по сравнению с сервером
# Для этого смотрим, изменены ли файлы, влияющие на сборку приложения
MUST_BUILD=false
if git status --porcelain | grep -qE '^(.. )(.+)'; then
    echo -e "${CLR_WARN}🔍 Обнаружены локальные изменения в коде. Требуется пересборка контейнера.${CLR_RESET}"
    MUST_BUILD=true
else
    echo -e "${CLR_SUCCESS}💤 Локальный код не изменялся. Сборка Docker будет запущена в режиме проверки кэша.${CLR_RESET}"
fi

# 1. Синхронизация кода через rsync
echo -e "${CLR_INFO}📦 [1/4] Синхронизация файлов с сервером Hetzner...${CLR_RESET}"
rsync -avz --delete \
      --exclude '.git/' \
      --exclude 'tmp/' \
      --exclude 'log/' \
      --exclude 'node_modules/' \
      --exclude 'public/packs/' \
      --exclude 'public/assets/' \
      --exclude 'storage/' \
      ./ $USER@$SERVER_IP:$REMOTE_PATH

echo -e "${CLR_SUCCESS}✅ Синхронизация завершена.${CLR_RESET}"
echo "------------------------------------------------------------------------"

# 2. Удаленное выполнение сборки с учетом флага изменений
echo -e "${CLR_INFO}🐳 [2/4] Подключение к Hetzner и управление контейнерами...${CLR_RESET}"

ssh $USER@$SERVER_IP << EOF
  set -e
  cd $REMOTE_PATH

  if [ "$MUST_BUILD" = true ]; then
    echo -e "${CLR_WARN}🛠  Запуск полной сборки нового образа (--build web)...${CLR_RESET}"
    BUILDKIT_PROGRESS=plain docker compose up -d --build web
  else
    echo -e "${CLR_SUCCESS}🚀 Изменений в коде нет. Просто убеждаемся, что текущий контейнер запущен...${CLR_RESET}"
    docker compose up -d web
  fi

  echo "------------------------------------------------------------------------"

  # 3. Фаза проверки миграций базы данных
  echo -e "${CLR_INFO}🗄  [3/4] Проверка состояния схемы базы данных...${CLR_RESET}"
  sleep 4

  MIGRATIONS_PENDING=\$(docker compose exec -T web bundle exec rails db:migrate:status 2>/dev/null | grep "  down  " | wc -l || echo "0")

  if [ "\$MIGRATIONS_PENDING" -gt 0 ]; then
    echo -e "${CLR_WARN}⚡️ Обнаружены новые миграции (\$MIGRATIONS_PENDING). Запуск db:migrate...${CLR_RESET}"
    docker compose exec -T web bundle exec rails db:migrate
    docker compose restart web
  else
    echo -e "${CLR_SUCCESS}💎 Структура БД актуальна. Пропускаем шаг миграций.${CLR_RESET}"
  fi
  
  WEB_STATUS=\$(docker compose ps web --format "{{.Status}}")
  echo -e "${CLR_SUCCESS}📊 Текущий статус контейнера web: \$WEB_STATUS${CLR_RESET}"
  echo "------------------------------------------------------------------------"

  # 4. Очистка дискового пространства
  echo -e "${CLR_INFO}🧹 [4/4] Очистка старых слоев сборки...${CLR_RESET}"
  docker image prune -f
EOF

echo "========================================================================="
echo -e "${CLR_SUCCESS}🎉 [УСПЕХ] Деплой завершён! Конвейер отработал в оптимальном режиме.${CLR_RESET}"