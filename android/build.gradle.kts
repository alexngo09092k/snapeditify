
buildscript {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://developer.huawei.com/repo/")
        }
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.11.1")

        // Firebase Google Services
        classpath("com.google.gms:google-services:4.5.0")

        // Huawei AGConnect
        classpath("com.huawei.agconnect:agcp:1.9.6.300")
    }
}

plugins {
    alias(libs.plugins.agcp) apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://developer.huawei.com/repo/")
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
