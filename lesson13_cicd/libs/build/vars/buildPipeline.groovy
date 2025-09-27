def call(body) {
    def config= [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()


    pipeline {
    agent any

    tools {
        maven "3.9.2"
    }

    environment {
        VERSION = "1.0.${BUILD_NUMBER}" // global ENVs  ${YOUR_JENKINS_URL}/pipeline-syntax/globals#env
        MAVEN_REPO_PATH = "${WORKSPACE}/.m2/repository"
        APPS_FILE = "${config.APPS_FILE}"
    }

    stages {
        stage('Prepare') {
            steps {
                script {    
                    apps = readJSON file: env.APPS_FILE
                    buildStages = stagePrepare(apps, 'build')
                    testStages = stagePrepare(apps, 'test')
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    buildStages.each { build ->
                        parallel build
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    testStages.each { test ->
                        parallel test
                    }
                }
            }
            post {
                success {
                    script {
                        apps.each {app,value ->
                            dir(value.path) {
                                junit 'target/surefire-reports/*.xml'
                            }
                        }
                    }
                }
            }
        }
    }
}


}