# Lesson 12: Multibranch Pipeline с GitHub Integration

## 📋 Выполненные задания:

### 1. ✅ Настроить интеграцию Jenkins - GitHub
- Установлены необходимые плагины: GitHub, GitHub Branch Source, Credentials
- Настроена интеграция с GitHub Personal Access Token
- Создана документация по настройке credentials

### 2. ✅ Реализовать multibranch pipeline для сборки проекта Webbooks
- **Сборка PR**: только сборка и юнит-тесты
- **Сборка main**: сборка + тесты + создание артефакта + запуск deploy pipeline

### 3. ✅ Реализовать pipeline для деплоя артефакта
- Создан отдельный `Jenkinsfile.deploy` для деплоя
- Деплой происходит в Docker контейнер
- Pipeline принимает параметры (имя артефакта, номер сборки)

## 🔧 Созданные файлы:

### Основные файлы:
- `lesson12_cicd/Jenkinsfile` - multibranch pipeline
- `lesson12_cicd/Jenkinsfile.deploy` - deploy pipeline
- `lesson12_cicd/docker-compose.yml` - Docker окружение
- `lesson12_cicd/Dockerfile.jenkins` - Jenkins образ с плагинами

### Документация:
- `lesson12_cicd/README.md` - полная инструкция по настройке
- `lesson12_cicd/github-credentials-setup.md` - настройка GitHub credentials
- `lesson12_cicd/start.sh` - скрипт запуска инфраструктуры

## 🚀 Логика работы:

### Pull Request:
```
Checkout → Build → Test → [СТОП]
```

### Main ветка:
```
Checkout → Build → Test → Archive Artifacts → Trigger Deploy Pipeline
```

## 🛠️ Исправления в процессе разработки:

1. **Синтаксическая ошибка** - убрана лишняя закрывающая скобка в Jenkinsfile
2. **Maven версия** - убрана секция tools, используется системный Maven 3.8.7
3. **cleanWs() функция** - заменена на deleteDir() (плагин не установлен)

## 📊 Результат:
- ✅ Все задания выполнены
- ✅ Pipeline работает корректно
- ✅ Документация создана
- ✅ Готово к тестированию

## 🎯 Для проверки:
1. Запустить Jenkins: `cd lesson12_cicd && ./start.sh`
2. Настроить multibranch pipeline по инструкции в README.md
3. Создать тестовый PR для проверки логики
