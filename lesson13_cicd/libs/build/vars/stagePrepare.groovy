def call (apps, mode) {
    def build_stage_list = []
    def build_parallel_map = [:]

    apps.each { app, value ->
        if (mode == 'build') {
            build_parallel_map.put(app, stageBuildCreate(app, value.path))
        }
        if (mode == 'test') {
            build_parallel_map.put(app, stageTestCreate(app, value.path))
        }
    }

    build_stage_list.add(build_parallel_map)
    return build_stage_list
}