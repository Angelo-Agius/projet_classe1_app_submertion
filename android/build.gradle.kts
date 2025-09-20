import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get().asFile
rootProject.buildDir = newBuildDir

subprojects {
    val newSubprojectBuildDir = File(newBuildDir, project.name)
    project.buildDir = newSubprojectBuildDir
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
