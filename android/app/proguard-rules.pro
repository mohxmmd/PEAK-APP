# Keep Razorpay classes
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Keep ProGuard annotation classes (used by Razorpay and other libraries)
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Suppress warnings related to ProGuard annotations
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# Keep Firebase classes (if you're using Firebase)
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Gson classes (if you're using Gson for JSON parsing)
-keep class com.google.gson.** { *; }

# Keep Retrofit and OkHttp classes (if you're using them)
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }
   
# General rule to keep all your app classes
-keep class com.yourpackage.** { *; }
-dontwarn com.yourpackage.**

# If you use any other third-party libraries, add their ProGuard rules here
