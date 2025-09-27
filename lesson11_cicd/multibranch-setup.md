# Настройка Multibranch Pipeline для Webbooks

## 1. Настройка интеграции Jenkins - GitHub

### 1.1 Создание GitHub Personal Access Token

1. Перейдите в GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Создайте новый token с правами:
   - `repo` (полный доступ к репозиторию)
   - `admin:repo_hook` (управление webhooks)
   - `read:org` (чтение организационных данных)

### 1.2 Настройка Credentials в Jenkins

1. В Jenkins перейдите в **Manage Jenkins** → **Manage Credentials**
2. Выберите **System** → **Global credentials** → **Add Credentials**
3. Выберите **Secret text**
4. Заполните:
   - **Secret**: ваш GitHub Personal Access Token
   - **ID**: `github-token`
   - **Description**: `GitHub Personal Access Token`

### 1.3 Настройка GitHub Server

1. В Jenkins перейдите в **Manage Jenkins** → **Configure System**
2. Найдите секцию **GitHub**
3. Нажмите **Add GitHub Server**
4. Заполните:
   - **Name**: `GitHub`
   - **API URL**: `https://api.github.com`
   - **Credentials**: выберите созданный `github-token`
5. Нажмите **Test connection** для проверки

## 2. Создание Multibranch Pipeline

### 2.1 Создание нового Job

1. В Jenkins нажмите **New Item**
2. Введите имя: `webbooks-multibranch`
3. Выберите **Multibranch Pipeline**
4. Нажмите **OK**

### 2.2 Настройка Branch Sources

1. В разделе **Branch Sources** нажмите **Add source** → **GitHub**
2. Заполните:
   - **Credentials**: выберите `github-token`
   - **Owner**: ваш GitHub username или organization
   - **Repository**: `devops` (или имя вашего репозитория)
3. В разделе **Behaviors** добавьте:
   - **Discover branches**: выберите "All branches"
   - **Discover pull requests from origin**: выберите "Merging the pull request with the current target branch revision"

### 2.3 Настройка Build Configuration

1. **Mode**: `by Jenkinsfile`
2. **Script Path**: `Jenkinsfile` (по умолчанию)

### 2.4 Настройка Scan Multibranch Pipeline Triggers

1. Включите **Scan Multibranch Pipeline Triggers**
2. **Interval**: `1 minute` (или по необходимости)

## 3. Создание Deploy Pipeline

### 3.1 Создание отдельного Job для деплоя

1. В Jenkins нажмите **New Item**
2. Введите имя: `webbooks-deploy`
3. Выберите **Pipeline**
4. Нажмите **OK**

### 3.2 Настройка Pipeline

1. **Definition**: `Pipeline script from SCM`
2. **SCM**: `Git`
3. **Repository URL**: URL вашего репозитория
4. **Credentials**: выберите `github-token`
5. **Branch**: `*/main`
6. **Script Path**: `Jenkinsfile.deploy`

## 4. Настройка Webhooks (опционально)

### 4.1 В GitHub

1. Перейдите в ваш репозиторий → **Settings** → **Webhooks**
2. Нажмите **Add webhook**
3. Заполните:
   - **Payload URL**: `http://your-jenkins-url/github-webhook/`
   - **Content type**: `application/json`
   - **Events**: выберите "Just the push event"
4. Нажмите **Add webhook**

## 5. Логика работы Pipeline

### 5.1 Для Pull Request веток:
- ✅ Checkout кода
- ✅ Сборка проекта (Maven)
- ✅ Запуск юнит-тестов
- ❌ Создание артефакта (пропускается)
- ❌ Деплой (пропускается)

### 5.2 Для main ветки:
- ✅ Checkout кода
- ✅ Сборка проекта (Maven)
- ✅ Запуск юнит-тестов
- ✅ Создание и архивирование артефакта
- ✅ Запуск отдельного pipeline для деплоя

### 5.3 Deploy Pipeline:
- ✅ Получение параметров (имя артефакта, номер сборки)
- ✅ Остановка старого контейнера
- ✅ Сборка нового Docker образа
- ✅ Запуск нового контейнера
- ✅ Проверка здоровья приложения

## 6. Проверка работы

### 6.1 Создание Pull Request

1. Создайте новую ветку: `git checkout -b feature/test-pr`
2. Внесите изменения в код
3. Создайте Pull Request в GitHub
4. Проверьте, что Jenkins запустил сборку только для PR (без деплоя)

### 6.2 Мерж в main

1. Смержите Pull Request в main
2. Проверьте, что Jenkins запустил полный pipeline включая деплой

## 7. Полезные команды для отладки

```bash
# Проверка статуса контейнеров
docker-compose -f lesson11_cicd/docker-compose.yml ps

# Просмотр логов приложения
docker-compose -f lesson11_cicd/docker-compose.yml logs -f webbooks-app

# Проверка доступности приложения
curl http://localhost:8081/

# Перезапуск Jenkins
docker-compose -f lesson11_cicd/docker-compose.yml restart jenkins
```

## 8. Структура файлов

```
devops/
├── Jenkinsfile                 # Основной multibranch pipeline
├── Jenkinsfile.deploy         # Pipeline для деплоя
├── lesson11_cicd/
│   ├── docker-compose.yml     # Docker окружение
│   ├── Dockerfile.jenkins     # Jenkins образ
│   └── multibranch-setup.md   # Эта инструкция
└── apps/webbooks/
    ├── pom.xml               # Maven конфигурация
    └── Dockerfile            # Образ приложения
```

