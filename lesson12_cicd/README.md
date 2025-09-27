# Lesson 12: Multibranch Pipeline с GitHub Integration

## Задание
1. Настроить интеграцию Jenkins - GitHub
2. Реализовать multibranch pipeline для сборки проекта Webbooks:
   - сборка PR должна выполнять только сборку и юнит-тесты
   - сборка main должна дополнительно создавать артефакт и запускать другой pipeline для деплоя
3. Реализовать pipeline для деплоя артефакта на контейнер

## Быстрый старт

```bash
# Запуск инфраструктуры
./start.sh

# Открыть Jenkins
open http://localhost:8080
```

## Структура файлов

```
lesson12_cicd/
├── Jenkinsfile              # Multibranch pipeline
├── Jenkinsfile.deploy       # Deploy pipeline
├── docker-compose.yml       # Docker окружение
├── Dockerfile.jenkins       # Jenkins образ с плагинами
├── start.sh                 # Скрипт запуска
└── README.md               # Эта документация
```

## Настройка Jenkins

### 1. Создание GitHub Token
1. GitHub → Settings → Developer settings → Personal access tokens
2. Создать token с правами: `repo`, `admin:repo_hook`, `read:org`

### 2. Настройка Credentials в Jenkins
1. Manage Jenkins → Manage Credentials → System → Global credentials
2. Add Credentials → Secret text
3. Secret: ваш GitHub token
4. ID: `github-token`

### 3. Создание Multibranch Pipeline
1. New Item → Multibranch Pipeline
2. Имя: `webbooks-multibranch`
3. Branch Sources → Add source → GitHub
4. Credentials: `github-token`
5. Owner: ваш GitHub username
6. Repository: `devops`
7. Script Path: `lesson12_cicd/Jenkinsfile`

### 4. Создание Deploy Pipeline
1. New Item → Pipeline
2. Имя: `webbooks-deploy`
3. Definition: Pipeline script from SCM
4. SCM: Git
5. Repository URL: ваш репозиторий
6. Script Path: `lesson12_cicd/Jenkinsfile.deploy`

## Логика работы

### Pull Request:
- ✅ Checkout
- ✅ Build (Maven)
- ✅ Test (Unit tests)
- ❌ Archive (пропускается)
- ❌ Deploy (пропускается)

### Main branch:
- ✅ Checkout
- ✅ Build (Maven)
- ✅ Test (Unit tests)
- ✅ Archive artifacts
- ✅ Trigger deploy pipeline

### Deploy Pipeline:
- ✅ Download artifact
- ✅ Stop old container
- ✅ Build new image
- ✅ Deploy container
- ✅ Health check

## Проверка работы

1. Создайте PR ветку:
   ```bash
   git checkout -b feature/test-pr
   git commit -m "test change"
   git push origin feature/test-pr
   ```

2. Создайте Pull Request в GitHub

3. Проверьте, что Jenkins запустил сборку только для PR

4. Смержите PR в main

5. Проверьте, что запустился полный pipeline с деплоем

## Полезные команды

```bash
# Просмотр логов
docker-compose logs -f jenkins
docker-compose logs -f webbooks-app

# Перезапуск
docker-compose restart jenkins

# Остановка
docker-compose down

# Проверка приложения
curl http://localhost:8081/
```

## Troubleshooting

### Jenkins медленно запускается
- Увеличьте память для Docker Desktop
- Используйте `docker system prune` для очистки

### Ошибки подключения к GitHub
- Проверьте GitHub token
- Убедитесь, что token имеет нужные права

### Ошибки сборки Maven
- Проверьте подключение к PostgreSQL
- Убедитесь, что база данных запущена
