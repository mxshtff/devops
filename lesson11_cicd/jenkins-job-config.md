# Настройка Jenkins Job для Docker окружения

## Параметры сборки Maven

### Для Docker окружения используйте:

```
clean package -DDB.url=jdbc:postgresql://postgres:5432/webbooks -DDB.user=postgres -DDB.password=password -DskipTests
```

### Объяснение параметров:

- `postgres:5432` - имя сервиса PostgreSQL в Docker сети
- `webbooks` - имя базы данных
- `postgres` - пользователь БД
- `password` - пароль БД
- `-DskipTests` - пропустить тесты для ускорения сборки

## Настройка Jenkins Job

### 1. Создание Maven Project

1. В Jenkins нажмите **New Item**
2. Введите имя: `webbooks-docker-build`
3. Выберите **Maven project**
4. Нажмите **OK**

### 2. Настройка Source Code Management

- **Source Code Management**: Git
- **Repository URL**: URL вашего репозитория
- **Branch**: `*/main` или `*/master`

### 3. Настройка Build

- **Root POM**: `apps/webbooks/pom.xml`
- **Goals and options**: 
  ```
  clean package -DDB.url=jdbc:postgresql://postgres:5432/webbooks -DDB.user=postgres -DDB.password=password -DskipTests
  ```

### 4. Настройка Post-build Actions

#### Архивирование артефактов:
- **Post-build Actions** → **Archive the artifacts**
- **Files to archive**: `apps/webbooks/target/*.jar`
- **Only archive if build is successful**: ✓

#### Развертывание в Docker:
- **Post-build Actions** → **Execute shell**
- **Command**:
  ```bash
  # Остановить старый контейнер
  docker-compose stop webbooks-app
  
  # Пересобрать образ с новым JAR
  docker-compose build webbooks-app
  
  # Запустить новый контейнер
  docker-compose up -d webbooks-app
  
  # Проверить статус
  docker-compose ps webbooks-app
  ```

## Альтернативный подход - Pipeline

Создайте Pipeline job с Jenkinsfile:

```groovy
pipeline {
    agent any
    
    environment {
        DB_URL = 'jdbc:postgresql://postgres:5432/webbooks'
        DB_USER = 'postgres'
        DB_PASSWORD = 'password'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                dir('apps/webbooks') {
                    sh 'mvn clean package -DDB.url=${DB_URL} -DDB.user=${DB_USER} -DDB.password=${DB_PASSWORD} -DskipTests'
                }
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'apps/webbooks/target/*.jar', fingerprint: true
            }
        }
        
        stage('Deploy') {
            steps {
                sh '''
                    docker-compose stop webbooks-app
                    docker-compose build webbooks-app
                    docker-compose up -d webbooks-app
                    sleep 10
                    docker-compose ps webbooks-app
                '''
            }
        }
        
        stage('Health Check') {
            steps {
                sh 'curl -f http://localhost:8081 || exit 1'
            }
        }
    }
}
```

## Проверка доступности сервисов

### В Docker сети:
- PostgreSQL: `postgres:5432`
- Webbooks App: `webbooks-app:8080` (внутри сети)
- Webbooks App (внешний доступ): `localhost:8081`

### Проверка подключения к БД:
```bash
# Из Jenkins контейнера
docker exec jenkins ping postgres

# Проверка БД
docker exec postgres psql -U postgres -d webbooks -c "SELECT COUNT(*) FROM books;"
```

## Полезные команды

```bash
# Просмотр логов
docker-compose logs -f webbooks-app

# Перезапуск сервиса
docker-compose restart webbooks-app

# Проверка статуса
docker-compose ps

# Очистка и пересборка
docker-compose down
docker-compose up --build -d
```
