def call(app_name, app_path) {
    return {
        stage(app_name) {
            dir(app_path) {
                sh "mvn -B -DskipTests -Dmaven.repo.local=${MAVEN_REPO_PATH} -Dversion.application=${env.VERSION} clean package"
            }
        }
    }
}