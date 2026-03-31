allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Build directory configuration - output to project root build folder for Flutter compatibility
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

    // Disable Kotlin incremental compilation to avoid cross-drive issues
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions {
            incremental = false
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
