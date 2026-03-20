allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val rootBuildDir = rootProject.projectDir.parentFile.resolve("build")
rootProject.layout.buildDirectory.set(rootBuildDir)

subprojects {
    project.layout.buildDirectory.set(rootBuildDir.resolve(project.name))
}

subprojects {
    project.evaluationDependsOn(":app")

    tasks.withType<org.gradle.api.tasks.compile.JavaCompile>().configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
        options.compilerArgs.add("-Xlint:-options")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
