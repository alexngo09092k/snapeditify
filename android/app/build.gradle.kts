
plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")

    // Flutter Gradle Plugin must be applied after Android and Kotlin plugins.
    id("dev.flutter.flutter-gradle-plugin")

    // Huawei AGConnect
    alias(libs.plugins.agcp)
}

android {
    namespace = "app.snapeditify.studio"

    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        applicationId = "app.snapeditify.studio"

        minSdk = 26
        targetSdk = flutter.targetSdkVersion

        // Keep version configuration from local.properties
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")

            // Keep old release optimization settings
            isMinifyEnabled = true
            isShrinkResources = true

            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
}
