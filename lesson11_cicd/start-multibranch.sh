#!/bin/bash

# Скрипт для запуска Jenkins с поддержкой multibranch pipeline

echo "🚀 Запуск Jenkins с поддержкой multibranch pipeline..."

# Остановить существующие контейнеры
echo "⏹️  Остановка существующих контейнеров..."
docker-compose down

# Удалить старые образы (опционально)
echo "🗑️  Удаление старых образов..."
docker-compose down --rmi all

# Собрать и запустить контейнеры
echo "🔨 Сборка и запуск контейнеров..."
docker-compose up --build -d

# Ждем запуска Jenkins
echo "⏳ Ожидание запуска Jenkins..."
sleep 30

# Проверяем статус контейнеров
echo "📊 Статус контейнеров:"
docker-compose ps

# Проверяем доступность Jenkins
echo "🔍 Проверка доступности Jenkins..."
if curl -f http://localhost:8080 > /dev/null 2>&1; then
    echo "✅ Jenkins доступен по адресу: http://localhost:8080"
else
    echo "❌ Jenkins недоступен. Проверьте логи:"
    echo "docker-compose logs jenkins"
fi

# Проверяем доступность PostgreSQL
echo "🔍 Проверка доступности PostgreSQL..."
if docker exec postgres pg_isready -U postgres > /dev/null 2>&1; then
    echo "✅ PostgreSQL доступен"
else
    echo "❌ PostgreSQL недоступен"
fi

echo ""
echo "📋 Следующие шаги:"
echo "1. Откройте http://localhost:8080 в браузере"
echo "2. Следуйте инструкциям в multibranch-setup.md"
echo "3. Создайте multibranch pipeline для репозитория"
echo ""
echo "📖 Документация: lesson11_cicd/multibranch-setup.md"
echo ""
echo "🔧 Полезные команды:"
echo "  Просмотр логов: docker-compose logs -f"
echo "  Остановка: docker-compose down"
echo "  Перезапуск: docker-compose restart"

