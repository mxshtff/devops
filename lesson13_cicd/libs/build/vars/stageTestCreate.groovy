def call(app_name, app_path) {
    return {
        stage(app_name) {
            dir(app_path) {
                sh "mvn test"
            }
        }
    }
}