#!/bin/bash

echo "🚀 Запуск Jenkins Multibranch Pipeline для Lesson 12NEW..."

# Быстрая остановка
echo "⏹️  Остановка контейнеров..."
docker-compose down --remove-orphans

# Запуск с оптимизацией
echo "🔨 Запуск контейнеров..."
docker-compose up -d

echo "⏳ Ожидание запуска Jenkins (30 сек)..."
sleep 30

echo "📊 Статус:"
docker-compose ps

echo ""
echo "✅ Jenkins: http://localhost:8080"
echo "✅ Webbooks: http://localhost:8081"
echo "✅ PostgreSQL: localhost:5432"
echo ""
echo "📖 Настройка: README.md"
