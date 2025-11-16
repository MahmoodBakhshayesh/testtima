import java.util.Properties
import java.text.SimpleDateFormat
import java.util.Date
import com.android.build.gradle.internal.api.BaseVariantOutputImpl
import com.android.build.gradle.AppExtension

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

android {
    namespace = "com.abomis.abdc"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }


    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.abomis.abdc"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
//        minSdkVersion = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

afterEvaluate {
    val androidExt = extensions.findByName("android") as? AppExtension
    if (androidExt != null) {
        tasks.register("renameReleaseApk") {
            doLast {
                val versionName = androidExt.defaultConfig.versionName ?: "0.0.0"
                val versionCode = androidExt.defaultConfig.versionCode ?: 0
                val formattedDate = SimpleDateFormat("yyyy-MM-dd").format(Date())

                val releaseDir = file("$buildDir/outputs/apk/release")
                val originalApk = File(releaseDir, "app-release.apk")
                val newApkName = "abdc-($versionName-$versionCode)$formattedDate.apk"
                val renamedApk = File(releaseDir, newApkName)

                if (originalApk.exists()) {
                    originalApk.renameTo(renamedApk)
                    println("✅ APK renamed to: $newApkName")
                } else {
                    println("❌ APK not found at: ${originalApk.absolutePath}")
                }
            }
        }

        tasks.named("assembleRelease").configure {
            finalizedBy("renameReleaseApk")
        }
    } else {
        println("⚠️ 'android' extension not found. Are you in the right module?")
    }
}

dependencies {
    // 🔴 ADD THIS:
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // your other dependencies, e.g.:
    // implementation("org.jetbrains.kotlin:kotlin-stdlib:...")
}
