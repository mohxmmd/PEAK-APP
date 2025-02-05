import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/screens/settings/settings_controller.dart';
import 'package:peak_app/utils/theme.dart';
import 'package:peak_app/utils/translations.dart';
import 'package:peak_app/services/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await _initializeFirebase();
  await _loadEnvironmentVariables();
  _setDeviceOrientation();
  _setSystemUIOverlayStyle();
  _initializeControllers();
  runApp(const MyApp());
}

// Future<void> _initializeFirebase() async {
//   try {
//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//     debugPrint('Firebase initialized successfully.');

//     // Set up Crashlytics
//     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//     FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

//     // Initialize Firebase Analytics
//     FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//     debugPrint('Firebase Analytics initialized successfully.');

//     await analytics.logEvent(
//       name: 'app_initialized',
//       parameters: <String, Object>{
//         'platform': 'Flutter',
//         'version': '1.0.0',
//       },
//     );

//     debugPrint('App initialization event logged.');
//   } catch (e) {
//     debugPrint('❌Error initializing Firebase: $e');
//     rethrow;
//   }
// }

Future<void> _loadEnvironmentVariables() async {
  try {
    await dotenv.load(fileName: ".env");
    debugPrint('Environment variables loaded successfully.');
  } catch (e) {
    debugPrint('❌Error loading environment variables: $e');
    rethrow;
  }
}

void _setDeviceOrientation() {
  try {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    debugPrint('Device orientation locked to portrait.');
  } catch (e) {
    debugPrint('❌Error locking device orientation: $e');
  }
}

void _setSystemUIOverlayStyle() {
  try {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFEFC8),
        statusBarIconBrightness: Brightness.dark));
    debugPrint('System UI overlay style set.');
  } catch (e) {
    debugPrint('❌Error setting system UI overlay style: $e');
  }
}

void _initializeControllers() {
  try {
    Get.put(SettingsController());
    // NotificationService().initNotifications();
    debugPrint('Controllers and notification service initialized.');
  } catch (e) {
    debugPrint('❌Error initializing controllers or notification service: $e');
    FirebaseCrashlytics.instance.recordError(e, null);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      useInheritedMediaQuery: true,
      builder: (context, child) => GetMaterialApp(
        title: 'PEAK',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.mainTheme,
        navigatorKey: Get.key,
        initialRoute: Routes.splashScreen,
        getPages: Routes.list,
        translations: AppTranslations(),
        locale: const Locale('en'),
        fallbackLocale: const Locale('en'),
      ),
    );
  }
}
