# Lesson 12: Multibranch Pipeline с GitHub Integration

## ✅ Выполненные задания:

1. **Настроить интеграцию Jenkins - GitHub** ✅
   - Установлены плагины GitHub, GitHub Branch Source, Credentials
   - Настроена интеграция с GitHub Personal Access Token

2. **Реализовать multibranch pipeline для сборки проекта Webbooks** ✅
   - **PR ветки**: только сборка и юнит-тесты
   - **Main ветка**: сборка + тесты + артефакт + deploy pipeline

3. **Реализовать pipeline для деплоя артефакта** ✅
   - Создан отдельный `Jenkinsfile.deploy`
   - Деплой в Docker контейнер

## 🔧 Созданные файлы:
- `lesson12_cicd/Jenkinsfile` - multibranch pipeline
- `lesson12_cicd/Jenkinsfile.deploy` - deploy pipeline  
- `lesson12_cicd/docker-compose.yml` - Docker окружение
- `lesson12_cicd/README.md` - документация
- `lesson12_cicd/github-credentials-setup.md` - настройка credentials

## 🚀 Готово к тестированию!
