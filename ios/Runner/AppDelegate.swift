import UIKit
import Flutter
import Firebase
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      GeneratedPluginRegistrant.register(with: self)

      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions,
              completionHandler: { granted, error in
                  if let error = error {
                      print("Error requesting notification authorization: \(error)")
                  }
                  print("Notification permission granted: \(granted)")
              }
          )
      } else {
          let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
      }
      
      application.registerForRemoteNotifications()
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
      Messaging.messaging().apnsToken = deviceToken
      print("APNS Token: \(deviceToken)")
  }
}

// Handle notification while app is in foreground
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
      completionHandler([.alert, .badge, .sound])
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
      completionHandler()
  }
}
